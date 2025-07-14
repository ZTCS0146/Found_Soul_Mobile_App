import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/helper_widget/appbar.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/providers/login_provider.dart';
import 'package:found_soul_mobile_app/modules/profile/provider/profile_provider.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      Provider.of<ProfileProvider>(context, listen: false).fetchAndLoadUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        showBackButton: false,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: AppTheme.textPrimary),
            onPressed: () => Navigator.pushNamed(context, '/notification'),
          ),
        ],
      ),
      body: profileProvider.nameController.text.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 60.sp,
                          color: AppTheme.textPrimary,
                        ),
                        radius: 60.r,
                        backgroundColor: AppTheme.textSecondary,
                        backgroundImage: null, // Add actual image logic
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  _combinedInfoCard(profileProvider),
                  actionCard(context, loginProvider),
                ],
              ),
            ),
    );
  }

  Widget _combinedInfoCard(ProfileProvider provider) {
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
          _infoRow("Name", provider.nameController.text),
          _divider(),
          _infoRow("Email", provider.emailController.text),
          _divider(),
          _infoRow("Gender", provider.selectedGender),
        ],
      ),
    );
  }

  Widget actionCard(BuildContext context, LoginProvider loginProvider) {
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
          _actionRow("Change Password", () {
            Navigator.pushNamed(context, '/changepassword');
          }),
          _divider(),
          _actionRow("Edit Profile", () {
            Navigator.pushNamed(context, '/editProfile');
          }),
          _divider(),
          _actionRow("Logout", () {
            loginProvider.signOutUser(context);
          }),
        ],
      ),
    );
  }

  Widget _actionRow(String title, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTheme.tabBarTitle.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 16.sp),
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

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTheme.heading2.copyWith(fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: AppTheme.tabBarTitle.copyWith(
                fontWeight: FontWeight.w600, fontSize: 16.sp),
          ),
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
