import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/scanned_document.dart';
import '../services/document_storage.dart';
import '../services/scanner_service.dart';
import '../services/pdf_service.dart';
import '../services/share_service.dart';
import '../services/ad_service.dart';
import '../services/premium_service.dart';
import '../providers/language_provider.dart';
import '../l10n/app_localizations.dart';
import '../widgets/banner_ad_widget.dart';
import '../screens/premium_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DocumentStorage _storage = DocumentStorage();
  final ScannerService _scanner = ScannerService();
  final PdfService _pdfService = PdfService();
  final ShareService _shareService = ShareService();
  final AdService _adService = AdService();
  final PremiumService _premiumService = PremiumService();

  List<ScannedDocument> _documents = [];
  bool _isLoading = true;
  bool _isPremium = false;

  @override
  void initState() {
    super.initState();
    _loadDocuments();
    _checkPremiumStatus();
    _adService.loadInterstitialAd();
    _adService.loadRewardedAd();
  }

  Future<void> _checkPremiumStatus() async {
    final isPremium = await _premiumService.isPremium();
    if (mounted) {
      setState(() => _isPremium = isPremium);
    }
  }

  Future<void> _loadDocuments() async {
    setState(() => _isLoading = true);
    try {
      final documents = await _storage.loadDocuments();
      setState(() {
        _documents = documents;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        _showErrorSnackBar('Error loading documents: $e');
      }
    }
  }

  Future<void> _scanDocument() async {
    // Verificar si puede crear más documentos
    if (!await _premiumService.canCreateDocument()) {
      _showLimitReachedDialog();
      return;
    }

    try {
      final document = await _scanner.scanDocument();
      if (document != null) {
        // Mostrar diálogo para editar el nombre
        final newName = await _showNameDialog(
          context,
          initialName: document.name,
          isNewDocument: true,
        );
        
        if (newName != null && newName.isNotEmpty) {
          document.name = newName;
          setState(() {
            _documents.insert(0, document);
          });
          await _storage.saveDocuments(_documents);
          await _premiumService.incrementDocumentCount();
          
          // Mostrar interstitial ad después de guardar
          await _adService.showInterstitialAd();
          
          if (mounted) {
            _showSuccessSnackBar('Document scanned successfully');
          }
        } else {
          // Si cancela, eliminar las imágenes escaneadas
          await document.deleteImages();
        }
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        _showErrorSnackBar(l10n.errorScanning);
      }
    }
  }

  Future<void> _generateAndSharePdf(ScannedDocument document) async {
    final l10n = AppLocalizations.of(context)!;
    
    // Mostrar diálogo de carga
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(l10n.generatingPdf),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      // Generar PDF si no existe
      if (document.pdfPath == null) {
        final pdfPath = await _pdfService.generatePdf(document);
        document.pdfPath = pdfPath;
        await _storage.saveDocuments(_documents);
      }

      // Cerrar diálogo de carga
      if (mounted) {
        Navigator.of(context).pop();
      }

      // Compartir PDF
      await _shareService.sharePdf(document.pdfPath!, document.name);
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        _showErrorSnackBar(l10n.errorGeneratingPdf);
      }
    }
  }

  Future<void> _renameDocument(ScannedDocument document) async {
    final newName = await _showNameDialog(
      context,
      initialName: document.name,
      isNewDocument: false,
    );

    if (newName != null && newName.isNotEmpty && newName != document.name) {
      setState(() {
        document.name = newName;
      });
      await _storage.saveDocuments(_documents);
      if (mounted) {
        _showSuccessSnackBar('Document renamed successfully');
      }
    }
  }

  Future<void> _deleteDocument(ScannedDocument document) async {
    final l10n = AppLocalizations.of(context)!;
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteDocument),
        content: Text(l10n.deleteConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _storage.deleteDocument(document);
      setState(() {
        _documents.remove(document);
      });
      await _storage.saveDocuments(_documents);
    }
  }

  Future<String?> _showNameDialog(BuildContext context, {
    required String initialName,
    required bool isNewDocument,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: initialName);
    
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isNewDocument ? 'Name Document' : 'Rename Document'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Document name',
            hintText: 'Enter document name',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) => Navigator.of(context).pop(value.trim()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              final name = controller.text.trim();
              Navigator.of(context).pop(name.isEmpty ? initialName : name);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showLimitReachedDialog() async {
    final count = await _premiumService.getDocumentCount();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.workspace_premium, color: Colors.deepPurple[400]),
            const SizedBox(width: 12),
            const Text('Limit Reached'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You\'ve created $count/10 documents this month.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Upgrade to Premium for unlimited documents!',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.deepPurple, width: 2),
              ),
              child: const Column(
                children: [
                  Text(
                    '⭐ Get Premium',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('✓ Unlimited documents\n✓ No ads\n✓ Premium features'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _navigateToPremium();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Get Premium'),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToPremium() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const PremiumScreen()),
    );
    
    if (result == true) {
      await _checkPremiumStatus();
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Botón Premium
          if (!_isPremium)
            IconButton(
              icon: Icon(Icons.workspace_premium, color: Colors.deepPurple[400]),
              tooltip: 'Get Premium',
              onPressed: _navigateToPremium,
            ),
          
          // Botón selector de idioma
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            tooltip: 'Change Language',
            onSelected: (String languageCode) {
              final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
              languageProvider.setLocale(Locale(languageCode));
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'es',
                child: Row(
                  children: [
                    Text('🇪🇸'),
                    SizedBox(width: 8),
                    Text('Español'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'en',
                child: Row(
                  children: [
                    Text('🇺🇸'),
                    SizedBox(width: 8),
                    Text('English'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _documents.isEmpty
              ? _buildEmptyState(l10n)
              : _buildDocumentList(l10n),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _scanDocument,
        icon: const Icon(Icons.document_scanner),
        label: Text(l10n.scanDocument),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 120,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 24),
          Text(
            l10n.noDocuments,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.scanFirstDocument,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentList(AppLocalizations l10n) {
    return Column(
      children: [
        // Banner ad en la parte superior (solo si no es premium)
        if (!_isPremium) const BannerAdWidget(),
        
        // Lista de documentos
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _documents.length,
            itemBuilder: (context, index) {
              final document = _documents[index];
              return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _generateAndSharePdf(document),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.picture_as_pdf,
                      size: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${document.pageCount} ${l10n.pages}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(document.createdAt),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[500],
                              ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      if (value == 'share') {
                        _generateAndSharePdf(document);
                      } else if (value == 'rename') {
                        _renameDocument(document);
                      } else if (value == 'delete') {
                        _deleteDocument(document);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'share',
                        child: Row(
                          children: [
                            const Icon(Icons.share),
                            const SizedBox(width: 12),
                            Text(l10n.share),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'rename',
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 12),
                            Text('Rename'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            const Icon(Icons.delete, color: Colors.red),
                            const SizedBox(width: 12),
                            Text(
                              l10n.delete,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
