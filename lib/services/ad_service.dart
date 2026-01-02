import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'premium_service.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  final PremiumService _premiumService = PremiumService();
  
  // IDs de producción
  static const String _appId = 'ca-app-pub-8310480760366552~4561285788';
  static const String _bannerAdUnitId = 'ca-app-pub-8310480760366552/7357666058';
  static const String _interstitialAdUnitId = 'ca-app-pub-8310480760366552/4731502718';
  static const String _rewardedAdUnitId = 'ca-app-pub-8310480760366552/5727043704';

  // IDs de prueba (usar durante desarrollo)
  static const String _testBannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  static const String _testInterstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';
  static const String _testRewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917';

  // Usar IDs de prueba durante desarrollo
  static const bool _useTesting = true; // Cambiar a false antes de publicar

  String get bannerAdUnitId => _useTesting ? _testBannerAdUnitId : _bannerAdUnitId;
  String get interstitialAdUnitId => _useTesting ? _testInterstitialAdUnitId : _interstitialAdUnitId;
  String get rewardedAdUnitId => _useTesting ? _testRewardedAdUnitId : _rewardedAdUnitId;

  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  int _interstitialAdCounter = 0;
  static const int _interstitialAdFrequency = 3; // Mostrar cada 3 acciones

  Future<void> initialize() async {
    await MobileAds.instance.initialize();
    
    // Configurar dispositivos de prueba
    if (_useTesting) {
      await MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(
          testDeviceIds: ['YOUR_DEVICE_ID'], // Añade tu ID de dispositivo aquí
        ),
      );
    }
  }

  // ========== BANNER AD ==========
  Future<BannerAd?> createBannerAd() async {
    // No mostrar ads si es premium
    if (await _premiumService.isPremium()) {
      return null;
    }

    _bannerAd?.dispose();
    
    _bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print('Banner ad loaded');
        },
        onAdFailedToLoad: (ad, error) {
          print('Banner ad failed to load: $error');
          ad.dispose();
        },
      ),
    );

    await _bannerAd!.load();
    return _bannerAd;
  }

  void disposeBanner() {
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  // ========== INTERSTITIAL AD ==========
  Future<void> loadInterstitialAd() async {
    // No cargar ads si es premium
    if (await _premiumService.isPremium()) {
      return;
    }

    await InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          print('Interstitial ad loaded');
        },
        onAdFailedToLoad: (error) {
          print('Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  Future<void> showInterstitialAd() async {
    // No mostrar ads si es premium
    if (await _premiumService.isPremium()) {
      return;
    }

    _interstitialAdCounter++;

    // Mostrar solo cada X acciones
    if (_interstitialAdCounter < _interstitialAdFrequency) {
      return;
    }

    if (_interstitialAd == null) {
      await loadInterstitialAd();
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        _interstitialAdCounter = 0;
        loadInterstitialAd(); // Precargar el siguiente
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _interstitialAd = null;
        print('Interstitial ad failed to show: $error');
      },
    );

    await _interstitialAd!.show();
  }

  // ========== REWARDED AD ==========
  Future<void> loadRewardedAd() async {
    // Los rewarded ads se pueden mostrar incluso en premium
    // ya que ofrecen valor adicional al usuario
    
    await RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          print('Rewarded ad loaded');
        },
        onAdFailedToLoad: (error) {
          print('Rewarded ad failed to load: $error');
        },
      ),
    );
  }

  Future<bool> showRewardedAd({
    required Function() onUserEarnedReward,
  }) async {
    if (_rewardedAd == null) {
      await loadRewardedAd();
      return false;
    }

    bool rewardEarned = false;

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        loadRewardedAd(); // Precargar el siguiente
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _rewardedAd = null;
        print('Rewarded ad failed to show: $error');
      },
    );

    await _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        rewardEarned = true;
        onUserEarnedReward();
        print('User earned reward: ${reward.amount} ${reward.type}');
      },
    );

    return rewardEarned;
  }

  // ========== CLEANUP ==========
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
  }
}
