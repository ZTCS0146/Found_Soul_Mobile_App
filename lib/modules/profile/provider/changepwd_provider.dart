import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:found_soul_mobile_app/modules/profile/provider/profile_provider.dart';
import 'package:found_soul_mobile_app/modules/profile/screens/profile.dart';

class ChangePasswordProvider extends ChangeNotifier {
  
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
final GlobalKey<FormState> formChangePasswordKey = GlobalKey<FormState>();

  bool isLoading = false;

  // void submitChangePassword(BuildContext context) {
  //   if (!formForgotKey.currentState!.validate()) return;

  //   isLoading = true;
  //   notifyListeners();

  //   // Simulate API call
  //   Future.delayed(const Duration(seconds: 2), () {
  //     isLoading = false;
  //     notifyListeners();

  //     // You can navigate or show success
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Password changed successfully')),
  //     );
  //   });
  // }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


 

  /// ✅ Change password logic
  Future<void> changePassword(String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('No user is signed in.');
    }

    await user.updatePassword(newPassword);
  }

  /// ✅ Submit password change (with form validation + loader)
  Future<void> submitChangePassword(BuildContext context,ProfileProvider profileProvider) async {
    if (!formChangePasswordKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    final newPassword = passwordController.text.trim();

    try {
      await changePassword(newPassword);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully')),
      );
      debugPrint('Password updated.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please re-authenticate and try again.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Firebase error: ${e.message}')),
        );
      }
      debugPrint('Firebase error: ${e.code} - ${e.message}');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      debugPrint('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ✅ (Optional) Re-authenticate the user
  Future<void> reAuthenticate(String email, String oldPassword) async {
    final user = FirebaseAuth.instance.currentUser!;
    final credential = EmailAuthProvider.credential(
      email: email,
      password: oldPassword,
    );
    await user.reauthenticateWithCredential(credential);
  }
}


