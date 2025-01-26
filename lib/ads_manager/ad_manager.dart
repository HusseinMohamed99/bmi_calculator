import 'dart:developer';

import 'package:bmi_calculator/ads_manager/ad_unit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static BannerAd? bannerAd;
  static AppOpenAd? appOpenAd;
  static InterstitialAd? interstitialAd;

  static void loadAdBanner(void setState) {
    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdUnit.homeBanner, // Ensure this is a valid ad unit ID
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          log('Ad failed to load: $error');
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  static void loadAdOpen() {
    AppOpenAd.load(
      adUnitId: AdUnit.addOpen,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdFailedToLoad: (LoadAdError error) {
          log('App open ad failed to load: $error');
          appOpenAd?.dispose();
        },
        onAdLoaded: (AppOpenAd ad) {
          appOpenAd = ad;
          if (appOpenAd != null) {
            appOpenAd!.show();
          }
        },
      ),
    );
  }

  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdUnit.interstitialAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdFailedToLoad: (LoadAdError error) {
          log('Interstitial ad failed to load: $error');
          interstitialAd?.dispose();
        },
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          if (interstitialAd != null) {
            interstitialAd!.show();
          }
        },
      ),
    );
  }

  static void disposeAdBanner() {
    bannerAd?.dispose();
    bannerAd = null;
  }

  static void disposeInterstitialAd() {
    interstitialAd?.dispose();
    interstitialAd = null;
  }
}
