import '/core/utils/just_one_pointer/just_one_pointer_widget.dart';
import 'package:flutter/material.dart';

import 'app.dart';

import 'initializer.dart';

Future<void> main() async {
  Initializer.instance.init(() {
    runApp(const OnlyOnePointerRecognizerWidget(child: App()));
  });
}
