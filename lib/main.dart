import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/modules/bottom_navigation/screens/bottom_navigation.dart';
import 'package:found_soul_mobile_app/modules/event_module/screens/event_details.dart';
import 'package:found_soul_mobile_app/modules/event_module/screens/tab_bar_screen.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/screens/verify_email.dart';
import 'package:found_soul_mobile_app/modules/profile/provider/changepwd_provider.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/providers/login_provider.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/providers/signup_provider.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/screens/forgot_password.dart';
import 'package:found_soul_mobile_app/modules/profile/provider/profile_provider.dart';
import 'package:found_soul_mobile_app/modules/profile/screens/change_password.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/screens/login.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/screens/signup.dart';
import 'package:found_soul_mobile_app/modules/profile/screens/edit_profile.dart';
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
 ChangeNotifierProvider(create: (_) =>  ChangePasswordProvider()),
  ChangeNotifierProvider(create: (_) =>  ProfileProvider())

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
          '/signup':(_)=>const SignupScreen(),
          '/changepassword':(_)=> ChangePasswordScreen(forgotPassword: false,),
          "/event":(context) => EventScreen(),
          "/eventdetails":(context) =>  const EventDetailsScreen(),
        "/bottomNavContainer":(context) =>   const BottomNavContainer(),
       "/editProfile":(context) =>   const EditProfileScreen(),
       "/forgotPassword":(context) =>   const ForgotPasswordScreen(),
       '/emailVerification':(context) => const VerifyEmailScreen(),
          },
          home: child,
        );
      },

    );
  }
}
