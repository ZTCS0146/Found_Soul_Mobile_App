import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider with ChangeNotifier {
  BuildContext? context;
     final GoogleSignIn googleSignIn = GoogleSignIn();


  void setContext(BuildContext ctx) {
    context = ctx;
  }

  void initSplash() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    Timer(const Duration(seconds: 2), () {
      checkLoginStatus();
    });
  });
}
  



 


  /// ✅ Check both normal Firebase login + Google sign-in
  Future<void> checkLoginStatus() async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      final googleUser = await googleSignIn.signInSilently();
      final prefs = await SharedPreferences.getInstance();
      final storedUid = prefs.getString('userId');

      if (firebaseUser != null && storedUid != null) {
        //  Normal Firebase Login
        Navigator.pushReplacementNamed(context!, '/bottomNavContainer');
      } else if (googleUser != null) {
        //Google Login
        Navigator.pushReplacementNamed(context!, '/bottomNavContainer');
      } else {
        // ❌ Not logged in
        Navigator.pushReplacementNamed(context!, '/onboarding');
      }
    } catch (e) {
      debugPrint('Auto login failed: $e');
      Navigator.pushReplacementNamed(context!, '/onboarding');
    }
  }
}


