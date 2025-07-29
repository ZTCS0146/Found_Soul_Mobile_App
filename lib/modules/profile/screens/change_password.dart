import 'package:flutter/material.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/helper_widget/app_button.dart';
import 'package:found_soul_mobile_app/helper_widget/appbar.dart';
import 'package:found_soul_mobile_app/helper_widget/textformfield_widget.dart';
import 'package:found_soul_mobile_app/modules/profile/provider/changepwd_provider.dart';
import 'package:found_soul_mobile_app/modules/profile/provider/profile_provider.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';

import 'package:provider/provider.dart';


class ChangePasswordScreen extends StatelessWidget {
   ChangePasswordScreen({super.key,  required this.forgotPassword});

   bool forgotPassword=false;

  @override
  Widget build(BuildContext context) {
    final forgotProvider = Provider.of<ChangePasswordProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      appBar:forgotPassword==true? CustomAppBar(title: "New Password",showBackButton: true,):CustomAppBar(title: "Change Password",showBackButton: true,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child:Form(
  key: forgotProvider.formChangePasswordKey, // <- this is required!
  child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            forgotPassword==true?    SizedBox(height: 8.h):Container(),


                          forgotPassword==true?  Text(
                  "Verification code sent to xyz@gmail.com",
                   style: AppTheme.heading2):Container(),
                          
                
             forgotPassword==true?    SizedBox(height: 8.h):Container(),
                     
            CustomTextField(
  hintText: "Old Password",
  controller: forgotProvider.oldPasswordController,
  isPassword: true,
  obscureText: true,
  validator: (value) {
    if (value == null || value.length < 6) {
      return "Old password must be at least 6 characters";
    }
    return null;
  },
),
SizedBox(height: 16.h),
CustomTextField(
  hintText: "New Password",
  controller: forgotProvider.newPasswordController,
  isPassword: true,
  obscureText: true,
  validator: (value) {
    if (value == null || value.length < 6) {
      return "New password must be at least 6 characters";
    }
    return null;
  },
),

            SizedBox(height: 24.h),
            appButton(
              "Change Password",
           
              (){
                forgotProvider.reAuthenticateAndChangePassword(context: context);
              },isLoading:    forgotProvider.isChangingPassword,
              // provider.isLoading
              //     ? null
              //     : () => provider.submitChangePassword(context),
            ),
          ],
        ),
      ),
    ));
  }
}

