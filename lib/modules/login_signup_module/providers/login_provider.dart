import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginProvider extends ChangeNotifier {
  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
 final forgotEmailController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
 GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();

  // Validation status (optional if you want UI state management)
  bool isLoading = false;
  bool isSignOutLoading = false;
  // Dispose method
  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  // Validate Form
  bool validateForm() {
    return loginFormKey.currentState?.validate() ?? false;
  }
  bool validateForgotForm() {
    return forgotFormKey.currentState?.validate() ?? false;
  }
  // Submit Login
  Future<void> login(BuildContext context) async {
    if (!validateForm()) return;

    isLoading = true;
    notifyListeners();

    try {
      // Simulate login delay or perform API call
      await Future.delayed(const Duration(seconds: 2));

        Navigator.pushReplacementNamed(context, '/bottomNavContainer');

      // Navigate to home or dashboard, etc.
    } catch (e) {
      debugPrint('Login failed: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

   Future<void> forgotPassword(BuildContext context) async {
    if (!validateForgotForm()) return;

    isLoading = true;
    notifyListeners();

    try {
      // Simulate login delay or perform API call
      await Future.delayed(const Duration(seconds: 2));

        Navigator.pushReplacementNamed(context, '/otpVerification');

      // Navigate to home or dashboard, etc.
    } catch (e) {
      debugPrint('Login failed: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }




Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      // User canceled the sign-in
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in cancelled')),
      );
      return;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final User? user = userCredential.user;

    if (user != null) {
      Navigator.pushReplacementNamed(context, '/bottomNavContainer');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in failed')),
      );
    }
  } catch (e) {
    print('Google Sign-In Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
  }
}
Future<void> signOutUser(BuildContext context) async {
  isSignOutLoading = true;
  notifyListeners(); // Start loader

  try {
    final googleSignIn = GoogleSignIn();
    
    // Sign out from Google if signed in
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }

    // Firebase sign out
    await FirebaseAuth.instance.signOut();

    // Navigate to login screen
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  } catch (e) {
    print('Sign out error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logout failed: ${e.toString()}')),
    );
  } finally {
    isSignOutLoading = false;
    notifyListeners(); // Stop loader
  }
}



}
