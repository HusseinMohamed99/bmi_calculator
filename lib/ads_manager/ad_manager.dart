import 'package:bmi_calculator/ads_manager/ad_unit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static BannerAd? bannerAd;
  static void loadAdBanner(void setState) {
    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdUnit.homeBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    )..load();
  }
}
