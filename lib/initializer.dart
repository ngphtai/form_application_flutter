import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dsoft_form_application/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '/shared/widget/toast_widget/pop_up_interruption.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'common/logger/app_logger.dart';
import 'core/locators/locators.dart';
import 'core/utils/app_bloc_observer.dart';

class Initializer {
  static final Initializer _singleton = Initializer._();
  static Initializer get instance => _singleton;

  Initializer._();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  void init(VoidCallback runApp) {
    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      _subscriberBlocObserver();

      await Hive.initFlutter();
      setUpLocator();
      await preferredOrientations();

      await ScreenUtil.ensureScreenSize();

      _initStatusBar();

      _initConnectivityMonitor();

      //Crashlytics
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      //init Firebase Analytics
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

      runApp();
    }, (
      error,
      stack,
    ) {
      AppLogger.instance.d('runZonedGuarded: ${error.toString()}');
      _showNoInternetDialog();
    });
  }

  void _initStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: const Color(0xfff7f7f7),
      statusBarIconBrightness: Brightness.light,
    ));
  }

  static Future<void> preferredOrientations() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void _subscriberBlocObserver() {
    const isLogEnable = false;
    Bloc.observer = AppBlocObserver(isLogEnable: isLogEnable);
  }

  void _initConnectivityMonitor() {
    final Connectivity connectivity = Connectivity();

    // Check initial connectivity status
    _checkInitialConnectivity(connectivity);

    // Subscribe to connectivity changes
    connectivitySubscription = connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        _showNoInternetDialog();
      } else {
        AppLogger.instance.d('Connected to network: $result');
      }
    });
  }

  Future<void> _checkInitialConnectivity(Connectivity connectivity) async {
    final List<ConnectivityResult> result =
        await connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      _showNoInternetDialog();
    }
  }

  void _showNoInternetDialog() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      showDiaLogInterruptedInternet(context);
    } else {
      AppLogger.instance.e("Navigator context is null. Cannot show dialog.");
    }
  }
}
