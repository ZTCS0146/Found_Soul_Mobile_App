import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  // Form Key
  final GlobalKey<FormState> formForgotKey = GlobalKey<FormState>();



  // Loading State
 bool isProfileLoading = false;
  bool isProfileUpdateLoading = false;

  // Image State
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Getter for image file
  File? get imageFile => _imageFile;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String selectedGender ="Female";
  final List<String> genders = ['Male', 'Female', 'Other'];
  /// Pick image from gallery or camera
  Future<void> pickImage(ImageSource source, {void Function(File image)? onImagePicked}) async {
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      notifyListeners(); // Update UI

      if (onImagePicked != null) {
        onImagePicked(_imageFile!);
      }
    }
  }

// get User Profile


 

  Future<void> fetchAndLoadUserProfile() async {
    try {
      isProfileLoading = true;
      notifyListeners();

      final uid = FirebaseAuth.instance.currentUser!.uid;
      final snap = await FirebaseDatabase.instance.ref('users/$uid').get();

      if (!snap.exists) throw Exception('Profile missing in RTDB');

      final data = Map<String, dynamic>.from(snap.value as Map);

      // Populate your controllers and dropdown
      nameController.text = data['name'] ?? '';
      emailController.text = data['email'] ?? '';
      selectedGender = data['gender'] ?? 'Female';

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading profile: $e');
      rethrow;
    } finally {
      isProfileLoading = false;
      notifyListeners();
    }
  }

Future<void> updateUserProfile() async {
  try {
    isProfileUpdateLoading = true;
    notifyListeners();

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');

    final updatedData = {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'gender': selectedGender,
      'updatedAt': DateTime.now().toIso8601String(),
    };

    await FirebaseDatabase.instance.ref('users/$uid').update(updatedData);

    debugPrint('User profile updated successfully.');
  } catch (e) {
    debugPrint(' Failed to update user profile: $e');
    rethrow;
  } finally {
    isProfileUpdateLoading = false;
    notifyListeners();
  }
}

  /// Set loading state
  void setLoading(bool value) {
    isProfileLoading = value;
    notifyListeners();
  }

  // Logout function
  Future<void> signOutUser(BuildContext context) async {
  // isSignOutLoading = true;
  notifyListeners(); // Start loader (optional for UI state)

  try {
    final googleSignIn = GoogleSignIn();

    // 1.  Sign out from Google if signed in
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }

    // 2.  Sign out from Firebase
    await FirebaseAuth.instance.signOut();

    // 3.  Clear UID from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');

    // 4.  Navigate to login or onboarding screen
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  } catch (e) {
    print('Logout failed: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logout failed: ${e.toString()}')),
    );
  } finally {
    // isSignOutLoading = false;
    notifyListeners(); // Stop loader
  }
}

}
