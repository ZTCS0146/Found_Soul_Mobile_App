import 'package:flutter/material.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  void submitChangePassword(BuildContext context) {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      isLoading = false;
      notifyListeners();

      // You can navigate or show success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully')),
      );
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
