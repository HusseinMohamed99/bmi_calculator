import 'dart:developer';

import 'package:bmi_calculator/bmi_calculator_app.dart';
import 'package:bmi_calculator/core/helpers/constant/constant.dart';
import 'package:bmi_calculator/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await _initializeFirebase();
  await ScreenUtil.ensureScreenSize();
  if (kReleaseMode) {
    try {
      await requestReview();
    } catch (e) {
      log('Error requesting review: $e');
    }
  }

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  appVersion = packageInfo.version;

  runApp(BmiCalculatorApp());
}

Future<void> requestReview() async {
  final InAppReview inAppReview = InAppReview.instance;

  if (await inAppReview.isAvailable()) {
    await inAppReview.requestReview();
  }
}

Future<void> _initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kReleaseMode) {
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
}
