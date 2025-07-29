import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';


Widget socialButton(String buttonText,IconData icon, VoidCallback onPressed){
  return
Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onPressed,
                        icon:  Icon(icon, color: Colors.white),
                        label: Text(
                         buttonText,
                          style:AppTheme.caption
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white24),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    );
}

