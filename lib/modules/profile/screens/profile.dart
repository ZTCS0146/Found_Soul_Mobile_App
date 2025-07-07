

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/custom_icon/custom_icons_icons.dart';
import 'package:found_soul_mobile_app/helper_widget/appbar.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: CustomAppBar(title: 'Profile',showBackButton :false),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 24.h),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60.r,
                       backgroundColor: AppTheme.textSecondary,
                  backgroundImage: null, // Replace with NetworkImage(...) for real photo
                ),
                Positioned(
                  // bottom: 50,
                  right: 45.sp,
                  // top:90,
                  child: CircleAvatar(
                    radius: 14.r,
                    backgroundColor: AppTheme.buttonColor,
                    child: Icon(CustomIcons.edit, size: 14.sp, color: AppTheme.backgroundColor),
                  ),
                )
              ],
            ),
            SizedBox(height: 30.h),
    Column(
  children: [
    SizedBox(height: 24.h),
    // Profile picture with edit
    
    SizedBox(height: 30.h),

    // 👇 Now all 3 in one card
    _combinedInfoCard(),

    // 👇 Bottom actions
   actionCard(context)
  ],
)

          ],
        ),
      ),
    
    );
  }
Widget actionCard(BuildContext context) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 20.h),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(14.r),
    ),
    child: Column(
      children: [
        _actionRow("Change Password",(){
         Navigator.pushNamed(context, '/changepassword');
        }),
        _divider(),
        _actionRow("Logout",(){}),
      ],
    ),
  );
}
Widget _actionRow(String title,VoidCallback onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:AppTheme.tabBarTitle.copyWith(fontWeight: FontWeight.w600,fontSize: 16.sp),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: AppTheme.textPrimary,
            size: 18.sp,
          ),
        ],
      ),
    ),
  );
}

// NEW WIDGET
Widget _combinedInfoCard() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 20.h),
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoRow("Name", "Cameron Williamson"),
        _divider(),
        _infoRow("Email", "Cameron_w@gmail.com"),
        _divider(),
        _infoRow("Gender", "Female"),
      ],
    ),
  );
}

Widget _infoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTheme.heading2.copyWith(fontWeight: FontWeight.w400),
               ),
        SizedBox(height: 4.h),
        Text(value,
            style: AppTheme.tabBarTitle.copyWith(fontWeight: FontWeight.w600,fontSize: 16.sp),),
      ],
    ),
  );
}

Widget _divider() {
  return Divider(
    color: AppTheme.textSecondary,
    thickness: 1,
    height: 16.h,
  );
}

}
