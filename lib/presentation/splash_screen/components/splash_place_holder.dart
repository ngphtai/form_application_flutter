import '/core/styles/app_icons.dart';
import 'package:flutter/material.dart';

/// {@template splash_place_holder}
/// Splash place holder during checking auth
/// {@endtemplate}
class SplashPlaceHolder extends StatelessWidget {
  /// {@macro splash_place_holder}
  const SplashPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppIcons.logo),
      ),
    );
  }
}
