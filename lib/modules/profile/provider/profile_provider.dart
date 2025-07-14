import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  // Form Key
  final GlobalKey<FormState> formForgotKey = GlobalKey<FormState>();



  // Loading State
 bool isProfileLoading = false;
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

      // ✅ Populate your controllers and dropdown
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

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
  }




  /// Set loading state
  void setLoading(bool value) {
    isProfileLoading = value;
    notifyListeners();
  }

  /// Dispose controllers
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
