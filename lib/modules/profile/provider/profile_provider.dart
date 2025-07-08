import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  // Form Key
  final GlobalKey<FormState> formForgotKey = GlobalKey<FormState>();



  // Loading State
  bool isLoading = false;

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

  /// Set loading state
  void setLoading(bool value) {
    isLoading = value;
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
