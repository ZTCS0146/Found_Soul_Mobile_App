import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/helper_widget/appbar.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Receive notifications passed via route arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Example: fallback demo list if nothing is passed
    final List<Map<String, dynamic>> notifications = args?['notifications'] != null
        ? List<Map<String, dynamic>>.from(args!['notifications'])
        : [
            {
              "title": "Welcome!",
              "message": "Thanks for installing the app.",
              "time": "Just now",
              "image": null,
            }
          ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(
        title: 'Notifications',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: notifications.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = notifications[index];

                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:  Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: item['image'] != null && item['image'] != ""
                              ? Image.network(
                                  item['image'],
                                  width: 48.w,
                                  height: 48.h,
                                  fit: BoxFit.cover,
                                )
                              : null
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'] ?? 'No Title',
                                style: AppTheme.caption.copyWith(color: AppTheme.backgroundColor),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['message'] ?? 'No Message',
                                style: AppTheme.heading2.copyWith(color: AppTheme.backgroundColor),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item['time'] ?? '',
                                style: AppTheme.heading2.copyWith(color: AppTheme.backgroundColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
