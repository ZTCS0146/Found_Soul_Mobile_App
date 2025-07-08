import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';

class CustomDropdownField extends StatelessWidget {
  final String hintText;
  final String? value;
  final List<String> items;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomDropdownField({
    Key? key,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.backgroundColor,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.
        vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) {
        return 
        SafeArea(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 🔺 Close icon at top right
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Option',
                style: AppTheme.heading2.copyWith(fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppTheme.textPrimary),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        const Divider(),

        // 🔽 List of options
        Expanded(
     child:    ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          itemCount: items.length,
          separatorBuilder: (_, __) => Divider(color: AppTheme.textSecondary),
          itemBuilder: (_, index) {
            final item = items[index];
            return ListTile(
              title: Text(item, style: AppTheme.heading2),
              onTap: () {
                Navigator.pop(context);
                if (onChanged != null) onChanged!(item);
              },
            );
          },
        ))])); 
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: TextEditingController(text: value ?? ''),
          validator: validator,
          readOnly: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: AppTheme.heading2.copyWith(fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppTheme.textSecondary),
            suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppTheme.textPrimary),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppTheme.textSecondary),
              borderRadius: BorderRadius.circular(8.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppTheme.textSecondary),
              borderRadius: BorderRadius.circular(8.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent),
              borderRadius: BorderRadius.circular(8.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent),
              borderRadius: BorderRadius.circular(8.r),
            ),
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 16.sp),
          ),
        ),
      ),
    );
  }
}
