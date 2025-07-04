import 'dart:async';
import 'package:flutter/material.dart';

class SplashProvider with ChangeNotifier {
  BuildContext? context;

  void setContext(BuildContext ctx) {
    context = ctx;
  }

  void initSplash() {
    Timer(const Duration(seconds: 2), () {
      // Navigate to next screen after splash
      if (context != null) {
Navigator.pushReplacementNamed(context!, '/onboarding');      }
    });
  }
}
