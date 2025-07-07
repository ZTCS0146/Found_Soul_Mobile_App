import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:found_soul_mobile_app/helper_widget/event_list.dart';
import 'package:found_soul_mobile_app/helper_widget/event_policy.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.backgroundColor,
          title:  Text('Event Detail', style: AppTheme.buttonText),
          centerTitle: true,
         leading: IconButton(onPressed: (){
          Navigator.of(context).pop();

         },icon: Icon(Icons.arrow_back_ios),)
        ),body:  ListView(
        padding:  EdgeInsets.all(16),
        children:  [   const EventCard(
          imageUrl: 'https://img.freepik.com/premium-photo/singer-performing-live-concert_954932-2255.jpg',
          title: 'Indie Vibes Night....',
          description: 'Experience raw, soulful sounds...',
          location: '3605 Parker Rd...',
          dateTime: '12 June 2025, 05:00 PM',
          isdetails: true,
        ),
  
        Divider(height: 2, thickness: 2, color: AppTheme.cardColor,),
        Padding(
          padding:  const EdgeInsets.symmetric(vertical: 16),
          child: Text("Venue Policies",style: AppTheme.eventListTitle),
        ),
           const PolicyItem(
            text: 'Tickets are non-refundable unless the event is canceled.',
            highlight: true,
          ),
           const PolicyItem(
              text:
                  'E-tickets must be shown at entry; no physical ticket required.'),
           const PolicyItem(
              text:
                  'Entry will not be allowed after the gate closing time.'),
           const PolicyItem(
              text:
                  'Government-issued ID may be required at the venue.'),
           const PolicyItem(
              text:
                  'Minimum age for entry is 18+ (unless specified).'),
      
    ]));
}}