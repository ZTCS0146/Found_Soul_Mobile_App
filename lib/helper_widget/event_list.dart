import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/custom_icon/custom_icons_icons.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';

class EventCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String location;
  final String dateTime;
  final bool isdetails;

  const EventCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.location,
    required this.dateTime,
    required this.isdetails
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color:isdetails ?Colors.transparent:  AppTheme        .cardColor,
      margin:  EdgeInsets.only(bottom: 16.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📸 Event Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 180.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // 📋 Title + Description
          Padding(
            padding:  EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTheme.eventListTitle),
                 SizedBox(height: 2.h),
                Text(description,
                    style: AppTheme.heading2.copyWith(fontSize:12.sp,color: AppTheme.textSecondary)),
                 SizedBox(height: 10.h),
              isdetails? Column(
                children: [
Row(
                  children: [
                     Icon(Icons.location_on, color: AppTheme.textPrimary, size: 16.sp),
                     SizedBox(width: 4.w),
                    Expanded(
                      child: Text(location,
                          style: AppTheme.eventListSubTitle),
                    ),]),
                    SizedBox(height: 12.h,),
                    Row(children: [
                  const Icon(Icons.calendar_today, color: AppTheme.textPrimary, size: 16),
                     SizedBox(width: 4.w),
                    Text(dateTime,
                        style: AppTheme.eventListSubTitle),

                    ],)
                ],
              ):
                Row(
                  children: [
                     Icon(CustomIcons.location, color: AppTheme.textPrimary, size: 16.sp),
                     SizedBox(width: 4.w),
                    Expanded(
                      child: Text(location,
                          style: AppTheme.eventListSubTitle),
                    ),
                     SizedBox(width: 8),
                    const Icon(Icons.calendar_today, color: AppTheme.textPrimary, size: 16),
                     SizedBox(width: 4.w),
                    Text(dateTime,
                        style: AppTheme.eventListSubTitle),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}