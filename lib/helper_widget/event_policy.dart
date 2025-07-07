// ✅ Reusable Policy Widget
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';

class PolicyItem extends StatelessWidget {
  final String text;
  final bool highlight;

  const PolicyItem({
    super.key,
    required this.text,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(8.sp),
    
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Icon(Icons.check_circle, color: AppTheme.secondaryColor, size: 26.sp),
           SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: AppTheme.eventListSubTitle
            ),
          ),
        ],
      ),
    );
  }
}
