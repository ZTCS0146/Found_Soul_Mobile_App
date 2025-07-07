import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // 🔹 Colors
  static const Color primaryColor = Colors.black;
  static const Color secondaryColor = Color(0xFF47FF46);
  static const Color backgroundColor = Colors.black;
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF696969);
  static const Color buttonColor = Color(0xFF46FC50);
  static const Color buttonSecondaryColor = Color(0xFFFFFFFF);
   static const Color errorColor=Colors.redAccent;
static const Color cardColor = Color(0xFF121212);
  // 🔹 Sizes
  static const double padding = 16.0;
  static const double spacing = 12.0;
  static const double radius = 8.0;
  static const double iconSize = 24.0;

  // 🔹 Text Styles
  static  TextStyle heading1 = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w400,
    color: textPrimary,
    fontFamily: 'Anton'
  );

  static  TextStyle heading2 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: textPrimary,
      fontFamily: 'Roboto'
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: textPrimary,
  );

  static  TextStyle caption = TextStyle(
    fontSize: 16.sp,
   color: buttonSecondaryColor,
    fontFamily: 'Anton',
    fontWeight: FontWeight.w400,
  );
    static  TextStyle subcaption = TextStyle(
    fontSize: 12.sp,
   color: buttonSecondaryColor,
    fontFamily: 'Anton',
    fontWeight: FontWeight.w400,
  );
    static  TextStyle buttonText = TextStyle(
    fontSize: 20.sp,
    color: buttonSecondaryColor,
    fontFamily: 'Anton',
    fontWeight: FontWeight.w400,
    
  );
    static  TextStyle tabBarTitle = TextStyle(
    fontSize: 14.sp,
    color: buttonSecondaryColor,
    fontFamily: 'RobotoBold',
    fontWeight: FontWeight.w700,
    
  );  
   static  TextStyle eventListTitle = TextStyle(
    fontSize: 18.sp,
    color: buttonSecondaryColor,
    fontFamily: 'RobotoExtraBold',
    fontWeight: FontWeight.w800,
    
  );  

     static  TextStyle eventListSubTitle = TextStyle(
    fontSize: 12.sp,
    color: buttonSecondaryColor,
    fontFamily: 'RobotoMedium',
    fontWeight: FontWeight.w500,
    
  );  

  // 🔹 ThemeData
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: textPrimary,
          elevation: 0,
        ),
        textTheme:  TextTheme(
          headlineLarge: heading1,
          headlineMedium: heading2,
          bodyLarge: body,
          bodyMedium: caption,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: textPrimary,
            textStyle: buttonText,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
            ),
          ),
        ),
      );
}
