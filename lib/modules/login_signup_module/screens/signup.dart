import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/helper_widget/app_button.dart';
import 'package:found_soul_mobile_app/helper_widget/state_drop_down.dart';
import 'package:found_soul_mobile_app/helper_widget/textformfield_widget.dart';
import 'package:found_soul_mobile_app/modules/login_signup_module/providers/signup_provider.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';

import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {

  final provider = Provider.of<SignUpProvider>(context);
  return Scaffold(
    // backgroundColor: Colors.black,
    body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                                
                    //                         children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05),           
            Text("Sign Up", style: AppTheme.heading1),
            SizedBox(height: 8.h),
            Text(
              "Kindly provide your details in the fields below",
              style: AppTheme.heading2,
            ),
            SizedBox(height: 16.h),

            /// Scrollable form section
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: "UserName",
                        controller: provider.nameController,
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                                ? "UserName is required"
                                : null,
                      ),
                      SizedBox(height: 16.h),

                      // CustomTextField(
                      //   hintText: "Phone",
                      //   controller: provider.phoneController,
                      //   keyboardType: TextInputType.phone,
                      //   validator: (value) {
                      //     if (value == null || value.trim().isEmpty) {
                      //       return "Phone is required";
                      //     } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      //       return "Phone must be 10 digits";
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // SizedBox(height: 16.h),

                      CustomTextField(
                        hintText: "Email",
                        controller: provider.emailController,
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

                      // CustomTextField(
                      //   hintText: "Gender",
                      //   controller: provider.genderController,
                      //   validator: (value) =>
                      //       value == null || value.trim().isEmpty
                      //           ? "Gender is required"
                      //           : null,
                      // ),
                      // SizedBox(height: 16.h),
CustomDropdownField(
          hintText: 'Select State',
          value: provider.selectedState,
          items: provider.usStates,
          onChanged: (val) {
            provider.setSelectedState(val);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a state';
            }
            return null;
          },
        ),     SizedBox(height: 16.h),
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
                    ],
                  ),
                ),
              ),
            ),

            /// Fixed Bottom Button and Footer
            appButton("Sign Up",isLoading: provider.isLoading, () {
              provider.submit(context);
            }),
            SizedBox(height: 16.h),

            Center(
              child: InkWell(onTap: (){
                        Navigator.pushReplacementNamed(context, '/login');

              },
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: AppTheme.caption.copyWith(fontSize: 14),
                    children: [
                      TextSpan(
                        text: "Log In",
                        style: AppTheme.caption.copyWith(
                            fontSize: 14, color: AppTheme.buttonColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    ),
  );
}
  }
  

