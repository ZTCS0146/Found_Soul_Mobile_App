import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';

Widget appButton(String buttonText, VoidCallback? onPressed, {bool isLoading = false}) {
  return SizedBox(
    width: double.infinity,
    height: 48.h,
    child: ElevatedButton(
      onPressed: isLoading ? null : onPressed, // Disable if loading
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: isLoading
          ? SizedBox(
              width: 20.w,
              height: 20.w,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              buttonText,
              style: AppTheme.caption,
            ),
    ),
  );
}
