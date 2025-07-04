import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/providers/forgotpwd_provider.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/providers/login_provider.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/providers/signup_provider.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/screens/forgot_password.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/screens/login.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/screens/signup.dart';
import 'package:found_soul_mobile_app/modules/splash_module/screens/onboarding.dart';
import 'package:found_soul_mobile_app/modules/splash_module/providers/splash_provider.dart';
import 'package:found_soul_mobile_app/modules/splash_module/screens/splash.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashProvider()),
      ChangeNotifierProvider(create: (_) => SignUpProvider()),
 ChangeNotifierProvider(create: (_) => LoginProvider()),
 ChangeNotifierProvider(create: (_) =>  ChangePasswordProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (_) => const SplashScreen(),
            '/onboarding': (_) => const OnboardingScreen(),
          '/login':(_)=>LoginScreen(),
          '/signup':(_)=>SignupScreen(),
          '/forgot':(_)=>ChangePasswordScreen()
          },
          home: child,
        );
      },

    );
  }
}
