class AdUnit {
  static bool isAdTest = true;
  static String homeBanner = isAdTest
      ? "ca-app-pub-3940256099942544/6300978111"
      : "ca-app-pub-4479962845986675/5208652153";
  static String addOpen = isAdTest
      ? "ca-app-pub-3940256099942544/9257395921"
      : "ca-app-pub-4479962845986675/9874655472";

  static String interstitialAd = isAdTest
      ? "ca-app-pub-3940256099942544/1033173712"
      : "ca-app-pub-4479962845986675/4975055731";
}
