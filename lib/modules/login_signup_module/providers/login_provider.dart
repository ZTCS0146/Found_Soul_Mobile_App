import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/providers/signup_provider.dart';
import 'package:found_soul_mobile_app/util/shared_preference.dart';
import 'package:provider/provider.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:google_sign_in/google_sign_in.dart';


// import 'package:google_sign_in/google_sign_in.dart';

class LoginProvider extends ChangeNotifier {
  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
 final forgotEmailController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
 GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();
final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _realtimeDb = FirebaseDatabase.instance;
  // Validation status (optional if you want UI state management)
  bool isLoading = false;
  bool isSignOutLoading = false;
  Map<String, dynamic>? userProfile;
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
//    Future<void> login(BuildContext context) async {
//     if (!validateForm()) return;

//     isLoading = true;
//     notifyListeners();

//     try {
//       //  Firebase Login
//       final userCredential = await _auth.signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
      
// // Store user ID in shared preferences
//       final uid = userCredential.user!.uid;
//      try {
//       await storeUserId(uid);
//     } catch (e) {
//       print('Error storing user ID: $e');
//     }
//     //  Fetch user profile
//     final snapshot = await _realtimeDb.ref('users/$uid').get();

//     if (snapshot.exists) {
//       userProfile = Map<String, dynamic>.from(snapshot.value as Map);
//         print(" User data: $userProfile");
//         ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Login successful!")),
//       );
//         // Navigate to home screen
//         Navigator.pushReplacementNamed(context, '/bottomNavContainer');
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(" User data not found.")),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(" Login failed: ${e.message}")),
//       );
//     } catch (e) {
//       debugPrint('Login error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(" Unexpected error occurred.")),
//       );
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// Future<void> login(BuildContext context, state) async {
   
//   if (!validateForm()) return;

//   isLoading = true;
//   notifyListeners();

//   try {
//     // 🔐 Firebase Login
//     final userCredential = await _auth.signInWithEmailAndPassword(
//       email: emailController.text.trim(),
//       password: passwordController.text.trim(),
//     );

//     final uid = userCredential.user!.uid;

//     // 💾 Store user ID in shared preferences
//     try {
//       await storeUserId(uid);
//     } catch (e) {
//       print('Error storing user ID: $e');
//     }

//     final userRef = _realtimeDb.ref('users/$uid');
//     final snapshot = await userRef.get();

//     if (snapshot.exists) {
//       // ✅ Update only the 'state' field
//       await userRef.update({
//         'state': state?? '',
//       });

//       userProfile = Map<String, dynamic>.from(snapshot.value as Map)
//         ..['state'] = state ?? '';

//       print("✅ Updated state in user profile on login");

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Login successful!")),
//       );

//       // ✅ Navigate to home screen
//       Navigator.pushReplacementNamed(context, '/bottomNavContainer');
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("User data not found.")),
//       );
//     }
//   } on FirebaseAuthException catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Login failed: ${e.message}")),
//     );
//   } catch (e) {
//     debugPrint('Login error: $e');
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Unexpected error occurred.")),
//     );
//   } finally {
//     isLoading = false;
//     notifyListeners();
//   }
// }

  Future<void> login(BuildContext context, state) async {
  if (!validateForm()) return;

  isLoading = true;
  notifyListeners();

  try {
    // 🔐 Firebase Login
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    final uid = userCredential.user!.uid;

    // 💾 Store user ID in shared preferences
    try {
      await storeUserId(uid);
    } catch (e) {
      print('Error storing user ID: $e');
    }

    final userRef = _realtimeDb.ref('users/$uid');
    final snapshot = await userRef.get();

    if (snapshot.exists) {
      try {
        // ✅ Update only the 'state' field
        await userRef.update({
          'state': state ?? '',
        });

        userProfile = Map<String, dynamic>.from(snapshot.value as Map)
          ..['state'] = state ?? '';

        print("✅ Updated state in user profile on login");
      } catch (e) {
        print('⚠️ Error updating state: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update state.")),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful!")),
      );

      // ✅ Navigate to home screen
      Navigator.pushReplacementNamed(context, '/bottomNavContainer');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User data not found.")),
      );
    }
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login failed: ${e.message}")),
    );
  } catch (e) {
    debugPrint('Login error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Unexpected error occurred.")),
    );
  } finally {
    isLoading = false;
    notifyListeners();
  }
}

  Future<void> sendForgotPasswordEmail(BuildContext context, String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password reset email sent. Check your inbox.')),
    );

    debugPrint('Password reset link sent to $email');
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.message}')),
    );
    debugPrint('FirebaseAuthException: ${e.code} - ${e.message}');
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

// Future<void> signInWithGoogle(BuildContext context) async {
//   try {
//     final GoogleSignIn googleSignIn = GoogleSignIn();

//     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//     if (googleUser == null) {
//       // User canceled the sign-in
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Sign-in cancelled')),
//       );
//       return;
//     }

//     final GoogleSignInAuthentication googleAuth =
//         await googleUser.authentication;

//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     final UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);

//     final User? user = userCredential.user;

//     if (user != null) {
//       Navigator.pushReplacementNamed(context, '/bottomNavContainer');
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Sign-in failed')),
//       );
//     }
//   } catch (e) {
//     print('Google Sign-In Error: $e');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error: ${e.toString()}')),
//     );
//   }
// }
 


Future<void> signInWithApple(BuildContext context) async {
  try {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Create Firebase OAuth credential
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    // Sign in to Firebase
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);
// Store user ID in shared preferences
      final uid = userCredential.user!.uid;
     try {
      await storeUserId(uid);
    } catch (e) {
      print('Error storing user ID: $e');
    }
    // ✅ Show success snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Signed in as ${userCredential.user?.email ?? 'Apple User'}"),
      
      ),
    );

    // ✅ Navigate to home screen
    Navigator.pushReplacementNamed(context, '/bottomNavContainer');
  } catch (e) {
    // ❌ Show error snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Apple Sign-In failed: $e"),
        
      ),
    );
    print("Apple Sign-In failed: $e");
  }
}




}
