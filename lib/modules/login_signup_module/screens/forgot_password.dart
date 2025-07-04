import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/helper_widget/app_button.dart';
import 'package:found_soul_mobile_app/helper_widget/textformfield_widget.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/providers/forgotpwd_provider.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';
import 'package:provider/provider.dart';


class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangePasswordProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
     
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Form(
          key: provider.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 32.sp),
                child: Center(child: Text('Change Password', style: AppTheme.heading1)),
              ),
              CustomTextField(
                hintText: "Password",
                controller: provider.passwordController,
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
                controller: provider.confirmPasswordController,
                isPassword: true,
                obscureText: true,
                validator: (value) {
                  if (value != provider.passwordController.text) {
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
      ),
    );
  }
}
