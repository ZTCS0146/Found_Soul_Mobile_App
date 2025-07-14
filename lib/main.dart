import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/modules/bottom_navigation/screens/bottom_navigation.dart';
import 'package:found_soul_mobile_app/modules/event_module/providers/event_provider.dart';
import 'package:found_soul_mobile_app/modules/event_module/screens/event_details.dart';
import 'package:found_soul_mobile_app/modules/event_module/screens/tab_bar_screen.dart';
import 'package:found_soul_mobile_app/modules/iframe_module/screens/provider/iframe_provider.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/screens/verify_email.dart';
import 'package:found_soul_mobile_app/modules/notification_module/provider/notification_provider.dart';
import 'package:found_soul_mobile_app/modules/notification_module/screens/notification.dart';
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
import 'package:found_soul_mobile_app/util/navigation_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
      initOneSignal();

    await Firebase.initializeApp(); // This might fail if config files are missing
  } catch (e) {
    print('Firebase init error: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => WebViewProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        
      ],
      child: const MyApp(),
    ),
  );
}
Future<void> initOneSignal() async {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose); // Optional: useful for debugging

  OneSignal.initialize("bb4fb296-3956-4d55-985e-fa52d9d4b795");

  await OneSignal.Notifications.requestPermission(true);

  // Foreground notification handler
  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    event.preventDefault(); // Prevent default display
    // OneSignal.Notifications.displayNotification(event.notification);
    print("Foreground Notification: ${event.notification.jsonRepresentation()}");
  });

  // Notification click handler
  OneSignal.Notifications.addClickListener((event) {
    print("Notification Clicked: ${event.notification.jsonRepresentation()}");

    // Ex  final imageUrl = event.notification.bigPicture ??
                   event.notification.additionalData?['image'];
    NavigationService.navigatorKey.currentState?.pushNamed(
      '/notification',
    arguments: {
 "title": event.notification.title,
          "message": event.notification.body,
          "time": DateTime.now().toLocal().toString(),
          "image": null, // Add image if you have any in additionalData
  },
    );
  });
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
            navigatorKey: NavigationService.navigatorKey,

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
          "/eventdetails":(context) =>   EventDetailsScreen(),
        "/bottomNavContainer":(context) =>   const BottomNavContainer(),
       "/editProfile":(context) =>   const EditProfileScreen(),
       "/forgotPassword":(context) =>   const ForgotPasswordScreen(),
       '/emailVerification':(context) => const VerifyEmailScreen(),
          '/notification':(context) => const NotificationScreen(),
          },
          home: child,
        );
      },

    );
  }
}
