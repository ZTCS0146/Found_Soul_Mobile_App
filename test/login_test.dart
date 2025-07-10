import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/providers/login_provider.dart';

void main() {
  testWidgets('LoginProvider.login() sets loading and navigates on success', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => LoginProvider()
          ..emailController.text = 'test@example.com'
          ..passwordController.text = 'password123',
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) {
              final loginProvider = Provider.of<LoginProvider>(context, listen: false);
              return Scaffold(
                body: Form(
                  key: loginProvider.loginFormKey,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => loginProvider.login(context),
                      child: const Text('Login'),
                    ),
                  ),
                ),
              );
            },
            '/bottomNavContainer': (_) => const Scaffold(body: Center(child: Text('Home Screen'))),
          },
        ),
      ),
    );

    // Tap the button to trigger login
    await tester.tap(find.text('Login'));

    // Begin login (calls Future.delayed)
    await tester.pump(); // Triggers loading state
    await tester.pump(const Duration(milliseconds: 100)); // Slight delay to allow loading

    final loginProvider = Provider.of<LoginProvider>(
      tester.element(find.byType(ElevatedButton)),
      listen: false,
    );

    expect(loginProvider.isLoading, isTrue); // 💥 This should now pass

    // Wait for the 2-second login Future
    await tester.pump(const Duration(seconds: 2));

    // Check navigation worked
    expect(find.text('Home Screen'), findsOneWidget);

    // Final check
    expect(loginProvider.isLoading, isFalse);
  });
}
