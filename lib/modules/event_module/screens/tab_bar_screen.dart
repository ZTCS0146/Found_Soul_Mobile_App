import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/modules/bottom_navigation/screens/bottom_navigation.dart';
import 'package:found_soul_mobile_app/modules/event_module/screens/event_list.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';

class EventScreen extends StatelessWidget {
   EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.backgroundColor,
          title:  Text('Event', style: AppTheme.buttonText),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: AppTheme.textPrimary),
              onPressed: () {
                Navigator.pushNamed(context, '/notification');
              },
            ),
          ],
            bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.sp, vertical: 10.sp),
              child: Container(
                height: 42.h,
                decoration: const BoxDecoration(
                   color:AppTheme.cardColor
                
                ),
                child: TabBar(
                
                  indicator: BoxDecoration(
                    color: AppTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                    
                  ),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: EdgeInsets.zero,
                  labelStyle: AppTheme.tabBarTitle,
                  // unselectedLabelStyle: AppTheme.secondaryColor,
                  labelColor: AppTheme.textPrimary,
                  unselectedLabelColor: AppTheme.textPrimary,
                  tabs: [
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        child:  Text("Upcoming Event",style: AppTheme.tabBarTitle,),
                      ),
                    ),
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        child:  Text("Past Event",style: AppTheme.tabBarTitle.copyWith(fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body:  TabBarView(
          children: [
            EventCardList(isPast: false),
            EventCardList(isPast: true),
          ],
        ),
        // bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
      ),
    );
  }
}

