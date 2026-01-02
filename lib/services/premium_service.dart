import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'dart:async';

class PremiumService {
  static final PremiumService _instance = PremiumService._internal();
  factory PremiumService() => _instance;
  PremiumService._internal();

  final InAppPurchase _iap = InAppPurchase.instance;
  
  // ID del producto premium
  static const String premiumProductId = 'premium_no_ads';
  
  // Stream de compras
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  
  // Estado premium
  bool _isPremium = false;
  
  // Límites para versión gratuita
  static const int maxFreeDocumentsPerMonth = 10;
  
  Future<void> initialize() async {
    // Cargar estado premium guardado
    await _loadPremiumStatus();
    
    // Escuchar cambios en compras
    _subscription = _iap.purchaseStream.listen(
      _handlePurchaseUpdates,
      onDone: () {
        _subscription?.cancel();
      },
      onError: (error) {
        print('Error en purchase stream: $error');
      },
    );
  }

  Future<void> _loadPremiumStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool('is_premium') ?? false;
  }

  Future<void> _savePremiumStatus(bool isPremium) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_premium', isPremium);
    _isPremium = isPremium;
  }

  Future<bool> isPremium() async {
    return _isPremium;
  }

  // ========== GESTIÓN DE LÍMITES GRATUITOS ==========
  Future<int> getDocumentCount() async {
    final prefs = await SharedPreferences.getInstance();
    final lastReset = prefs.getString('last_reset') ?? '';
    final currentMonth = DateTime.now().toString().substring(0, 7); // YYYY-MM
    
    // Si es un nuevo mes, resetear contador
    if (lastReset != currentMonth) {
      await prefs.setString('last_reset', currentMonth);
      await prefs.setInt('document_count', 0);
      return 0;
    }
    
    return prefs.getInt('document_count') ?? 0;
  }

  Future<void> incrementDocumentCount() async {
    final prefs = await SharedPreferences.getInstance();
    final currentCount = await getDocumentCount();
    await prefs.setInt('document_count', currentCount + 1);
  }

  Future<bool> canCreateDocument() async {
    if (_isPremium) return true;
    
    final count = await getDocumentCount();
    return count < maxFreeDocumentsPerMonth;
  }

  Future<int> getRemainingDocuments() async {
    if (_isPremium) return -1; // Ilimitado
    
    final count = await getDocumentCount();
    return maxFreeDocumentsPerMonth - count;
  }

  // ========== COMPRAS IN-APP ==========
  Future<bool> isAvailable() async {
    return await _iap.isAvailable();
  }

  Future<ProductDetails?> getPremiumProduct() async {
    if (!await isAvailable()) {
      return null;
    }

    final ProductDetailsResponse response = await _iap.queryProductDetails({premiumProductId});
    
    if (response.notFoundIDs.isNotEmpty) {
      print('Productos no encontrados: ${response.notFoundIDs}');
      return null;
    }

    if (response.productDetails.isEmpty) {
      return null;
    }

    return response.productDetails.first;
  }

  Future<void> buyPremium() async {
    final product = await getPremiumProduct();
    
    if (product == null) {
      throw Exception('Producto premium no disponible');
    }

    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    await _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> restorePurchases() async {
    try {
      await _iap.restorePurchases();
    } catch (e) {
      print('Error al restaurar compras: $e');
      rethrow;
    }
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        // Verificar que sea nuestro producto
        if (purchaseDetails.productID == premiumProductId) {
          _savePremiumStatus(true);
        }
      }
      
      if (purchaseDetails.pendingCompletePurchase) {
        _iap.completePurchase(purchaseDetails);
      }
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}
