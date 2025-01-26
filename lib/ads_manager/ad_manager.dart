import 'dart:developer';

import 'package:bmi_calculator/ads_manager/ad_unit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static BannerAd? bannerAd;

  static void loadAdBanner(Function setState) {
    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdUnit.homeBanner, // Ensure this is a valid ad unit ID
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            // Ad successfully loaded
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          log('Ad failed to load: $error');
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  static void disposeAdBanner() {
    bannerAd?.dispose();
    bannerAd = null;
  }
}
