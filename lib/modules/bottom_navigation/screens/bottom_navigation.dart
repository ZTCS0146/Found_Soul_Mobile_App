import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/custom_icon/custom_icons_icons.dart';
import 'package:found_soul_mobile_app/modules/event_module/screens/event_details.dart';
import 'package:found_soul_mobile_app/modules/iframe_module/screens/playlist.dart';
import 'package:found_soul_mobile_app/modules/iframe_module/screens/shop.dart';
import 'package:found_soul_mobile_app/modules/map_module/screens/map.dart';
import 'package:found_soul_mobile_app/modules/profile/screens/profile.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';


class BottomNavContainer extends StatefulWidget {
  const BottomNavContainer({super.key});

  @override
  State<BottomNavContainer> createState() => _BottomNavContainerState();
}

class _BottomNavContainerState extends State<BottomNavContainer> {
  int currentIndex = 0;

  final List<Widget> pages =  [
    EventDetailsScreen(),
    ShopWebViewPage(),
    MapScreen(),
    PlaylistWebViewPage(),
    ProfileScreen()
  ];
  final List<String> titles = [
    'Events',
    'Shop',
    'Map',
    'Playlist',
    'Profile',
  ];
  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: onItemTapped,
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  get titles => [
        'Get Passes',
        'Shop',
        'Rave Location',
        'Playlists',
        'Profile',
      ];

  @override
  Widget build(BuildContext context) {
    const items = [
      CustomIcons.star,
         CustomIcons.shop,
               CustomIcons.location,
               Icons.video_collection_outlined,
                 CustomIcons.profile,
    
    ];

    return Container(
      height: 70.h,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = currentIndex == index;
          return GestureDetector(
            onTap: () => onTap?.call(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                     AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 2.h,
                  width: 24.w,
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.secondaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
               
                const SizedBox(height: 4),
            Icon(
                  items[index],
                  color: isSelected ? AppTheme.secondaryColor : AppTheme.buttonSecondaryColor ,
                ),
                
                const SizedBox(height: 4),
  
                
  Text(
            titles[index],
            style: AppTheme.tabBarTitle.copyWith(
                fontWeight: FontWeight.w600, fontSize: 12.sp),
          ),

                // Text(data)
              ],
            ),
          );
        }),
      ),
    );
  }
}

