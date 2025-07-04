import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  // Controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // Dispose controllers
  void disposeControllers() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    genderController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void submit() {
    if (validateForm()) {
      // Perform signup logic
      debugPrint("Sign up success with: ${emailController.text}");
    }
  }
}
