import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// {@template app_font_family}
/// Get font family using in app based on device type, OS type
/// {@endtemplate}
class AppFontFamily {
  /// Source Han Sands
  late final String appFont;

  /// {@macro app_font_family}
  AppFontFamily() {
    appFont = "Schyler";
  }

  /// Get font family based on device type, OS type
  /// Mobile size: Size(375, 718)
  /// Tablet size: Size(744, 1113)
  ///
  /// Calculate mobile and tablet device type base screen size
  ///
  /// if ((orientation == Orientation.portrait && screenWidth < 600) ||
  ///   (orientation == Orientation.landscape && screenHeight < 600)) {
  ///   deviceType = DeviceType.mobile;
  /// } else {
  ///   deviceType = DeviceType.tablet;
  /// }
  String getFontFamily() {
    return appFont;
  }

  TextStyle getGoogleFontTextStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
