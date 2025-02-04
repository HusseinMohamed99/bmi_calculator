import 'dart:developer';

import 'package:bmi_calculator/ads_manager/ad_unit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static BannerAd? bannerAd;
  static AppOpenAd? appOpenAd;
  static InterstitialAd? interstitialAd;
  static RewardedAd? rewardedAd;
  static bool isShowingAd = false;

  static void loadAdBanner(void Function() setState) {
    bannerAd?.dispose(); // Dispose of the previous banner
    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdUnit.homeBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('Banner Ad Loaded');
          setState();
        },
        onAdFailedToLoad: (ad, error) {
          log('Banner Ad failed to load: $error');
          ad.dispose();
          bannerAd = null;
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  static void loadAdOpen() {
    appOpenAd?.dispose(); // Dispose of previous instance
    appOpenAd = null;

    AppOpenAd.load(
      adUnitId: AdUnit.addOpen,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdFailedToLoad: (LoadAdError error) {
          log('App open ad failed to load: $error');
          appOpenAd = null;
        },
        onAdLoaded: (AppOpenAd ad) {
          appOpenAd = ad;

          appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              appOpenAd = null;
              log('App Open Ad dismissed');
              loadAdOpen();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              appOpenAd = null;
              log('App Open Ad failed to show: $error');
              loadAdOpen();
            },
          );

          appOpenAd?.show(); // Safe null check before showing
        },
      ),
    );
  }

  static void loadInterstitialAd() {
    interstitialAd?.dispose();
    interstitialAd = null;

    InterstitialAd.load(
      adUnitId: AdUnit.interstitialAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdFailedToLoad: (LoadAdError error) {
          log('Interstitial ad failed to load: $error');
          interstitialAd = null;
        },
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;

          interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              interstitialAd = null;
              log('Interstitial ad dismissed');
              loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              interstitialAd = null;
              log('Interstitial ad failed to show: $error');
              loadInterstitialAd();
            },
          );
        },
      ),
    );
  }

  static void loadRewardedAd(void Function() setState) {
    rewardedAd?.dispose();
    rewardedAd = null;

    RewardedAd.load(
      adUnitId: AdUnit.rewardedAd,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          log('Rewarded ad loaded');
          rewardedAd = ad;

          rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              rewardedAd = null;
              log('Rewarded ad dismissed');
              isShowingAd = false;
              setState();
              loadRewardedAd(setState);
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              rewardedAd = null;
              log('Rewarded ad failed to show: $error');
              loadRewardedAd(setState);
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('Rewarded ad failed to load: $error');
          rewardedAd = null;
        },
      ),
    );
  }

  static void showRewardedAd(void Function() setState) {
    if (rewardedAd != null) {
      rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          log('User earned reward: ${reward.amount} ${reward.type}');
          isShowingAd = true;
          setState();
        },
      );
    } else {
      log('No rewarded ad available, loading a new one...');
      loadRewardedAd(setState);
    }
  }

  static void disposeAdBanner() {
    bannerAd?.dispose();
    bannerAd = null;
  }

  static void disposeInterstitialAd() {
    interstitialAd?.dispose();
    interstitialAd = null;
  }

  static void disposeRewardedAd() {
    rewardedAd?.dispose();
    rewardedAd = null;
  }
}
