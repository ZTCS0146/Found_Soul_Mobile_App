import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/modules/splash_module/providers/splash_provider.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);
    splashProvider.setContext(context);
    splashProvider.initSplash();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash_logo.png',
              width: 260.w, // Responsive width
              height: 251.h, // Responsive height
              fit: BoxFit.contain,
            ),
           SizedBox(height: MediaQuery.of(context).size.height * 0.18),
             Image.asset(
              'assets/images/splash_text.png',
              width: 216.w, // Responsive width
              height: 13.h, // Responsive height
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}