import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeUserId(String uid) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', uid);
}

Future<String?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId');
}

Future<void> removeUserId() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userId');
}
Future<void> saveEmail(String email) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_email', email);
}
Future<String?> getEmail() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_email');
}
Future<void> removeEmail() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_email');
}
