import 'package:flutter/material.dart';

import '../../core/utils/just_one_pointer/just_one_pointer_widget.dart';

/// [AppStatus] extension
class AppStatus {
  AppStatus._();
  /// The app is already inside and is being used by the user
  /// Begin Splash screen
  static bool appIsAlreadyInside = false;

  /// Checking is showing keyboard
  static bool isOpenKeyboard(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0;
  }

  /// Closing keyboard is showing
  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// Enable multiple touching
  static void enableMultipleTouching() {
    OnlyOnePointerRecognizer.instance.setIsEnableMultiple(isEnable: true);
  }

  /// Disable multiple touching
  static void disableMultipleTouching() {
    OnlyOnePointerRecognizer.instance.setIsEnableMultiple(isEnable: false);
  }
}
