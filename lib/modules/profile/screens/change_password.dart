import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/helper_widget/app_button.dart';
import 'package:found_soul_mobile_app/helper_widget/appbar.dart';
import 'package:found_soul_mobile_app/helper_widget/textformfield_widget.dart';
import 'package:found_soul_mobile_app/modules/profile/provider/changepwd_provider.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';
import 'package:provider/provider.dart';


class ChangePasswordScreen extends StatelessWidget {
   ChangePasswordScreen({super.key,  required this.forgotPassword});

   bool forgotPassword=false;

  @override
  Widget build(BuildContext context) {
    final forgotProvider = Provider.of<ChangePasswordProvider>(context);

    return Scaffold(
      appBar:forgotPassword==true? CustomAppBar(title: "New Password",showBackButton: true,):CustomAppBar(title: "Change Password",showBackButton: true,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // forgotPassword==true?Container():Padding(
            //   padding:  EdgeInsets.symmetric(vertical: 32.sp),
            //   child: Center(child: Text('Change Password', style: AppTheme.heading1)),
            // ):Container()
            // Padding(
            //   padding:  EdgeInsets.symmetric(vertical: 32.sp),
            //   child: Center(child: Text(forgotPassword==true?
            // 'New Password':    'Change Password', style: AppTheme.heading1)),
            // ),
            forgotPassword==true?    SizedBox(height: 8.h):Container(),


                          forgotPassword==true?  Text(
                  "Verification code sent to xyz@gmail.com",
                   style: AppTheme.heading2):Container(),
                          
                
             forgotPassword==true?    SizedBox(height: 8.h):Container(),
                     
            CustomTextField(
              hintText: "Password",
              controller: forgotProvider.passwordController,
              isPassword: true,
              obscureText: true,
              validator: (value) {
                if (value == null || value.length < 6) {
                  return "Password must be at least 6 characters";
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              hintText: "Confirm Password",
              controller: forgotProvider.confirmPasswordController,
              isPassword: true,
              obscureText: true,
              validator: (value) {
                if (value != forgotProvider.passwordController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            SizedBox(height: 24.h),
            appButton(
              "Change Password",(){}
              // provider.isLoading
              //     ? null
              //     : () => provider.submitChangePassword(context),
            ),
          ],
        ),
      ),
    );
  }
}
