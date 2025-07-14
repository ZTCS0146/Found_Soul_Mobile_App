import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  // Controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseDatabase _realtimeDb = FirebaseDatabase.instance;

  final formKey = GlobalKey<FormState>();
  String? _selectedState;
  String? get selectedState => _selectedState;

  bool isLoading = false;

  final List<String> usStates = [
    'Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California',
    'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia',
    'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas',
    'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusetts',
    'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana',
    'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico',
    'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma',
    'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina',
    'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia',
    'Washington', 'West Virginia', 'Wisconsin', 'Wyoming',
  ];

  // State selection
  void setSelectedState(String? state) {
    _selectedState = state;
    notifyListeners();
  }

  // Validation
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // Dispose controllers
  void disposeControllers() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    genderController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  /// 📝 CREATE ACCOUNT with Loader and Reset
  Future<void> createAccount(BuildContext context) async {
    if (!validateForm()) return;

    isLoading = true;
    notifyListeners();

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final uid = userCredential.user!.uid;

      // ✅ Store user data in Realtime Database
      await _realtimeDb.ref('users/$uid').set({
        'uid': uid,
        'email': emailController.text.trim(),
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'gender': genderController.text.trim(),
        'state': selectedState ?? '',
        'password': passwordController.text.trim(),
        'createdAt': DateTime.now().toIso8601String(),
      });

      // ✅ Show success and clear fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully!")),
      );

      clearFormFields();

      // ✅ Navigate to login
      Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ ${e.message}")),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearFormFields() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    genderController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    _selectedState = null;
  }

  void submit(BuildContext context) {
    if (validateForm()) {
      createAccount(context);
      debugPrint("Sign up submitted with: ${emailController.text}");
    }
  }
}
