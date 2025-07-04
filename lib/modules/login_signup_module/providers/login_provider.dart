import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // Validation status (optional if you want UI state management)
  bool isLoading = false;

  // Dispose method
  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  // Validate Form
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // Submit Login
  Future<void> login(BuildContext context) async {
    if (!validateForm()) return;

    isLoading = true;
    notifyListeners();

    try {
      // Simulate login delay or perform API call
      await Future.delayed(const Duration(seconds: 2));

        Navigator.pushReplacementNamed(context, '/signup');

      // Navigate to home or dashboard, etc.
    } catch (e) {
      debugPrint('Login failed: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
