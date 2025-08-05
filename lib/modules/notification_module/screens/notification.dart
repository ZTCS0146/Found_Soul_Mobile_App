import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/helper_widget/appbar.dart';
import 'package:found_soul_mobile_app/modules/notification_module/provider/notification_model.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext pcontext) {
    final notificationBox = Hive.box<MyNotification>('notifications');

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(
        title: 'Notifications',
        showBackButton: true,
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: notificationBox.listenable(),
          builder: (context, Box<MyNotification> box, _) {
            final notifications = box.values.toList().reversed.toList();

            if (notifications.isEmpty) {
              return const Center(
                child: Text(
                  "No notifications received.",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = notifications[index];

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.imageUrl!,
                            width: 48.w,
                            height: 48.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                        const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: AppTheme.caption.copyWith(color: AppTheme.textPrimary),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.body,
                              style: AppTheme.heading2.copyWith(color: AppTheme.textPrimary),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              formatDateTime(item.receivedAt),
                              style: AppTheme.heading2.copyWith(color: AppTheme.textPrimary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String formatDateTime(DateTime time) {
    return "${time.day}/${time.month}/${time.year} ${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }
}
