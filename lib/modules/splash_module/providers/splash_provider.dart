import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SplashProvider with ChangeNotifier {
  BuildContext? context;
     final GoogleSignIn googleSignIn = GoogleSignIn();


  void setContext(BuildContext ctx) {
    context = ctx;
  }

  void initSplash() {
    Timer(const Duration(seconds: 2), () {
      checkLoginStatus();
    });
  }



 
  void checkLoginStatus() async {
    final user = await googleSignIn.signInSilently();
    if (user != null) {
     Navigator.pushReplacementNamed(context!, '/bottomNavContainer'); 
    } else {
     Navigator.pushReplacementNamed(context!, '/onboarding'); 
    }
  }
}
