import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/helper_widget/app_button.dart';
import 'package:found_soul_mobile_app/helper_widget/social_buttons.dart';
import 'package:found_soul_mobile_app/helper_widget/textformfield_widget.dart';
import 'package:found_soul_mobile_app/modules/profile/provider/changepwd_provider.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/providers/login_provider.dart';
import 'package:found_soul_mobile_app/modules/profile/screens/change_password.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 32.h),
          child: SingleChildScrollView(
            child: Form(
  key: loginProvider.loginFormKey,
  child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               SizedBox(height: MediaQuery.of(context).size.height*0.1),

                Text(
                  "Log In",
                  style: AppTheme.heading1,
                ),
                SizedBox(height: 8.h),
                Text(
                  "Kindly provide your details in the fields below",
                   style: AppTheme.heading2,
                ),
                SizedBox(height: 40.h),
            
                // Email
               CustomTextField(
                                hintText: "Email",
                                controller: loginProvider
                                .emailController,
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
                              ),
                              SizedBox(height: 16.h),
            
                // Password
                CustomTextField(
                                hintText: "Password",
                                controller: loginProvider.
                                passwordController,
                                isPassword: true,
                                obscureText: true,
                                validator: (value) {
                                   if (value == null || value.trim().isEmpty) {
      return "Please enter your password";
    }
                                  return null;
                                },
                              ),

                SizedBox(height: 12.h),
            
                InkWell(
                  onTap: (){
                                            Navigator.pushNamed(context, '/forgotPassword');

                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style:  AppTheme.heading2.copyWith(fontWeight: FontWeight.w400,fontSize: 12.sp),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
            
                // Login Button
               appButton("Login",  isLoading: loginProvider.isLoading,     () {
         loginProvider.login(context);
}),
                SizedBox(height: 20.h),
            
                // OR Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: AppTheme.textSecondary)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text('OR', style: AppTheme.subcaption),
                    ),
                    Expanded(child: Divider(color:AppTheme.textSecondary)),
                  ],
                ),
                SizedBox(height: 20.h),
            
                // Social Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    socialButton("Apple",Icons.apple,() {
         loginProvider.login(context);
}),
                    SizedBox(width: 16.w),
                    socialButton("Google",Icons.g_mobiledata,() {
         loginProvider.signInWithGoogle(context);
}),
                   
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.12),
           
                // Bottom Text
                InkWell(
                  onTap: (){
    
    Navigator.pushReplacementNamed(context, '/signup');

                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: AppTheme.caption.copyWith(fontSize: 14),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                        style: AppTheme.caption.copyWith(fontSize: 14,color: AppTheme.buttonColor),
                              
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //SizedBox(height: 16.h),
          
            ]),
          ),
        ),
      
    )));
  }
}
