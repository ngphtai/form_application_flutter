// ignore_for_file: unused_field

import 'package:flutter/material.dart';

import 'app_colors.dart';

/// [AppTheme] contains various custom themes and colors necessary for themes.
/// Themes include:
/// [darkTheme]
/// [lightTheme]
/// These are imported to other files/widgets to apply the required themes.
class AppTheme {
  AppTheme._();

  /// Dark theme for app
  static final darkTheme = ThemeData(
    // useMaterial3: true,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    //primaryTextTheme: AppTextStyle.textTheme,
    //  fontFamily: Constants.fontBeVietNam,
    appBarTheme: AppBarTheme(surfaceTintColor: AppColors.transparent),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      hintStyle: TextStyle(color: Colors.red),
      filled: true,
      fillColor: Colors.purple,
      errorMaxLines: 3,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );

  /// Light theme for app
  static final lightTheme = ThemeData(
    // useMaterial3: true,
    brightness: Brightness.dark,
  );
}
