import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24.h),
            
                // Logo
                Image.asset(
                  'assets/images/splash_logo.png',
                  height: 117.h,
                  width: 122.w,
                ),
            
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            
                // Main Crowd Image
                Image.asset(
                  'assets/images/onboarding.png',
                  fit: BoxFit.cover,
                ),
            
                SizedBox(height: 25.h),
            
                // Enter Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.buttonColor,
                    shape: const CircleBorder(),
                    padding: EdgeInsets.all(15.w),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: AppTheme.buttonSecondaryColor,
                  ),
                ),
            
                 Text(
                  'ENTER',
                  style: AppTheme.buttonText,
                ),
            
                SizedBox(height: 60.h),
            
                // Onboarding Text (Image)
                Image.asset(
                  'assets/images/onboarding_text.png',
                  width: 297.w,
                  height: 25.h,
                  fit: BoxFit.contain,
                ),
            
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}