import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../common/enums/app_enums.dart';
import '../../../common/logger/app_logger.dart';

import '../../../common/shared_prefs/theme_preference.dart';
import '../../../core/locators/locators.dart';
import '../../../core/styles/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeData> {
  late final ThemePreference _themePref;

  late ThemeType _themeType;

  ThemeType get themeType => _themeType;

  ThemeCubit() : super(AppTheme.darkTheme);

  void initialize() {
    _themePref = diThemePreference;
    final localeCurrent = _themePref.fetchThemeApp();
    _themeType = localeCurrent;
    changeTheme(localeCurrent);
  }

  void changeTheme(ThemeType type) async {
    AppLogger.instance.d(type.name);
    await _themePref.changeTheme(type: type);
    _themeType = type;
    final themeData = _getThemeDataByType(type);
    emit(themeData);
  }

  ThemeData _getThemeDataByType(ThemeType type) {
    switch (type) {
      case ThemeType.dark:
        return AppTheme.darkTheme;
      case ThemeType.light:
        return ThemeData();
    }
  }
}
