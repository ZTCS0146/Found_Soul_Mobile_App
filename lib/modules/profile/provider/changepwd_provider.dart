import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:found_soul_mobile_app/modules/profile/provider/profile_provider.dart';
import 'package:found_soul_mobile_app/modules/profile/screens/profile.dart';
import 'package:found_soul_mobile_app/util/shared_preference.dart';
import 'package:provider/provider.dart';

class ChangePasswordProvider extends ChangeNotifier {

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
final GlobalKey<FormState> formChangePasswordKey = GlobalKey<FormState>();

bool isChangingPassword = false;


  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }


 

 Future<void> reAuthenticateAndChangePassword({
  required BuildContext context,

}) async {
  
  try {
    isChangingPassword = true;
   notifyListeners();

    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? await getEmail();

    if (user == null || email == null || email.isEmpty) {
      throw Exception('User not logged in or email missing');
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password: oldPasswordController.text,
    );

    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPasswordController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password successfully changed')),
    );
    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Firebase error: ${e.message}')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  } finally {
    isChangingPassword = false;
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


