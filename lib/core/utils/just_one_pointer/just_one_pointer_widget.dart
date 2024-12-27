import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Only one pointer recognizer
class OnlyOnePointerRecognizer extends OneSequenceGestureRecognizer {
  /// Singleton
  static final instance = OnlyOnePointerRecognizer._();

  OnlyOnePointerRecognizer._();

  static bool _isEnableMultipleTouching = false;

  int _p = 0;

  /// Set is enable multiple touching
  // ignore: use_setters_to_change_properties
  void setIsEnableMultiple({required bool isEnable}) =>
      _isEnableMultipleTouching = isEnable;

  @override
  void addPointer(PointerDownEvent event) {
    if (_isEnableMultipleTouching) return;
    startTrackingPointer(event.pointer);

    if (_p == 0) {
      resolve(GestureDisposition.rejected);
      _p = event.pointer;
    } else {
      resolve(GestureDisposition.accepted);
    }
  }

  @override
  String get debugDescription => 'only one pointer recognizer';

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  void handleEvent(PointerEvent event) {
    if (_isEnableMultipleTouching) return;
    if (!event.down && event.pointer == _p) {
      _p = 0;
    }
  }
}

/// {@template only_one_pointer_recognizer_widget}
/// Just support only one pointer at the moment
/// {@endtemplate}
class OnlyOnePointerRecognizerWidget extends StatelessWidget {
  /// {@macro only_one_pointer_recognizer_widget}
  const OnlyOnePointerRecognizerWidget({super.key, this.child});

  /// Child to builder
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(gestures: <Type, GestureRecognizerFactory>{
      OnlyOnePointerRecognizer:
          GestureRecognizerFactoryWithHandlers<OnlyOnePointerRecognizer>(
              () => OnlyOnePointerRecognizer.instance, (instance) {})
    }, child: child);
  }
}
