import 'dart:io';
import 'package:flutter/material.dart';
import 'package:found_soul_mobile_app/helper_widget/app_button.dart';
import 'package:found_soul_mobile_app/helper_widget/appbar.dart';
import 'package:found_soul_mobile_app/helper_widget/textformfield_widget.dart';
import 'package:found_soul_mobile_app/modules/profile/provider/profile_provider.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  



  @override
  Widget build(BuildContext context) {
         final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: const CustomAppBar(title: 'Edit Profile',showBackButton :false,
     
      ),
    
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
          
              /// Profile image with edit icon
              Padding(
                padding: EdgeInsets.only(bottom: 20.h), // 👈 Extra space to avoid cut-off
                child: Stack(
                      clipBehavior: Clip.none, // 👈 Allow overflow

                  alignment: Alignment.center,
                  children: [profileProvider.imageFile != null?  CircleAvatar(
                      radius: 55.r,
                      backgroundImage:
                        FileImage(profileProvider.imageFile!),
                  ):
                    CircleAvatar(
                      radius: 55.r,child: Icon(Icons.person, size: 60.sp, color: AppTheme.textPrimary),),
                  
                  Positioned(
                    bottom: -16.h,
                    child: GestureDetector(
                      onTap: () => showImageSourceSheet(context, profileProvider),
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: AppTheme.buttonColor,
                        child: const Icon(Icons.edit, size: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),),
               SizedBox(height: 30.h),
              CustomTextField(
                                  hintText: "Name",
                                  controller: profileProvider.nameController,
                                  keyboardType: TextInputType.emailAddress,
                                 
                                ),
              SizedBox(height: 30.h),
          
              /// Name field
                CustomTextField(
                                  hintText: "Email",
                                  controller: profileProvider.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                 
                                ),
  SizedBox(height: 30.h),          
              /// Email field
            
          
              /// Gender dropdown
             /// Gender dropdown
DropdownButtonFormField<String>(
  value: profileProvider.genders.contains(profileProvider.selectedGender)
      ? profileProvider.selectedGender
      : null, // Fallback if value is invalid
  decoration: InputDecoration(
    hintText: "Gender",
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppTheme.textSecondary),
      borderRadius: BorderRadius.circular(8.r),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppTheme.textSecondary, width: 2),
      borderRadius: BorderRadius.circular(8.r),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppTheme.primaryColor),
      borderRadius: BorderRadius.circular(8.r),
    ),
  ),
  style: const TextStyle(color: AppTheme.textPrimary),
  dropdownColor: AppTheme.backgroundColor,
  items: profileProvider.genders.map((gender) {
    return DropdownMenuItem<String>(
      value: gender,
      child: Text(gender),
    );
  }).toList(),
  onChanged: (val) {
    if (val != null) {
      setState(() {
        profileProvider.selectedGender = val;
      });
    }
  },
),

              SizedBox(height: 30.h),
          appButton("Save Details", () {
            profileProvider.updateUserProfile();

          },
          isLoading: profileProvider.isProfileUpdateLoading),
              /// Save button
           
            ],
          ),
        ),
      ),
    );
  }

  

  void showImageSourceSheet(BuildContext context,profileProvider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.white),
              title: const Text("Take Photo", style: TextStyle(color: Colors.white)),
              onTap: () {
            Navigator.pop(context);
              profileProvider.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.white),
              title: const Text("Choose from Gallery", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                profileProvider.pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
