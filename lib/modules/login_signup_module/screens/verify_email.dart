import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/helper_widget/app_button.dart';
import 'package:found_soul_mobile_app/helper_widget/appbar.dart';
import 'package:found_soul_mobile_app/helper_widget/textformfield_widget.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/providers/login_provider.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';

import 'package:provider/provider.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: "Forgot Password",showBackButton: true,),
      body: Padding(
        padding:  EdgeInsets.all(16.sp),
        child:SingleChildScrollView(
            child: Form(
  key: loginProvider.forgotFormKey,
  child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 32.0),
               Text(
                  "Verify Email",
                  style: AppTheme.heading1,
                ),
                SizedBox(height: 8.h),
                Text(
                  "Verification code sent to xyz@gmail.com",
                   style: AppTheme.heading2,
                ),                SizedBox(height: 8.h),

                     CustomTextField(
                                hintText: "Email",
                                controller: loginProvider.forgotEmailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Email is required";
                                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                      .hasMatch(value)) {
                                    return "Enter a valid email";
                                  }
                                  return null;
                                },
                              ), const SizedBox(height: 16.0),
           
          appButton("Verify Otp", () {
               Navigator.pushNamed(
  context,
  '/changePassword',
  arguments: {
    'forgotPassword': true
    
  },
);

           }),
          ],
        ),
      ),
    )));
  }
}

