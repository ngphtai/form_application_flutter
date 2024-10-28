import 'dart:async';

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

  void init(VoidCallback runApp) {
    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      _subscriberBlocObserver();

      await Hive.initFlutter();
      setUpLocator();
      await preferredOrientations();

      // await _fetchThemeApp();

      await ScreenUtil.ensureScreenSize();

      _initStatusBar();
      runApp();
    }, (error, stack) {
      AppLogger.instance.d('runZonedGuarded: ${error.toString()}');
    });
  }

  void _initStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.orange,
      systemNavigationBarColor: Colors.red,
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

  Future<void> _fetchThemeApp() async {
    await diThemePreference.initialize();
    diThemePreference.fetchThemeApp();
  }
}
