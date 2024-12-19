// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// [AppTextStyle] contains various custom text styles using Google Fonts.
class AppTextStyle {
  AppTextStyle._();

  /// Regular styles
  static final _fontFamily = _FontFamily();
  static final TextStyle regular9 = _fontFamily.regular(fontSize: 9);
  static final TextStyle regular10 = _fontFamily.regular(fontSize: 10);
  static final TextStyle regular11 = _fontFamily.regular(fontSize: 11);
  static final TextStyle regular12 = _fontFamily.regular(fontSize: 12);
  static final TextStyle regular13 = _fontFamily.regular(fontSize: 13);
  static final TextStyle regular14 = _fontFamily.regular(fontSize: 14);
  static final TextStyle regular15 = _fontFamily.regular(fontSize: 15);
  static final TextStyle regular16 = _fontFamily.regular(fontSize: 16);
  static final TextStyle regular18 = _fontFamily.regular(fontSize: 18);
  static final TextStyle regular19 = _fontFamily.regular(fontSize: 19);
  static final TextStyle regular20 = _fontFamily.regular(fontSize: 20);
  static final TextStyle regular22 = _fontFamily.regular(fontSize: 22);
  static final TextStyle regular24 = _fontFamily.regular(fontSize: 24);
  static final TextStyle regular26 = _fontFamily.regular(fontSize: 26);
  static final TextStyle regular28 = _fontFamily.regular(fontSize: 28);

  /// Bold styles
  static final TextStyle bold9 = _fontFamily.bold(fontSize: 9);
  static final TextStyle bold10 = _fontFamily.bold(fontSize: 10);
  static final TextStyle bold11 = _fontFamily.bold(fontSize: 11);
  static final TextStyle bold12 = _fontFamily.bold(fontSize: 12);
  static final TextStyle bold13 = _fontFamily.bold(fontSize: 13);
  static final TextStyle bold14 = _fontFamily.bold(fontSize: 14);
  static final TextStyle bold15 = _fontFamily.bold(fontSize: 15);
  static final TextStyle bold16 = _fontFamily.bold(fontSize: 16);
  static final TextStyle bold18 = _fontFamily.bold(fontSize: 18);
  static final TextStyle bold19 = _fontFamily.bold(fontSize: 19);
  static final TextStyle bold20 = _fontFamily.bold(fontSize: 20);
  static final TextStyle bold22 = _fontFamily.bold(fontSize: 22);
  static final TextStyle bold24 = _fontFamily.bold(fontSize: 24);
  static final TextStyle bold26 = _fontFamily.bold(fontSize: 26);
  static final TextStyle bold28 = _fontFamily.bold(fontSize: 28);
}

class _FontFamily {
  TextStyle regular({required double fontSize}) {
    return GoogleFonts.beVietnamPro(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle bold({required double fontSize}) {
    return GoogleFonts.beVietnamPro(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }
}
