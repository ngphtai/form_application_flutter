import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

const bool _kReleaseMode = kReleaseMode;

/// [AppLoggerOutput] custom logger output for different types of platforms
class AppLoggerOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    if (_kReleaseMode || !Platform.isIOS) {
      event.lines.forEach(debugPrint);
    } else {
      event.lines.forEach(developer.log);
    }
  }
}
