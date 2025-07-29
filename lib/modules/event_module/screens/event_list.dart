import 'package:flutter/material.dart';
import 'package:found_soul_mobile_app/helper_widget/event_list.dart';



class EventCardList extends StatelessWidget {
  bool isPast;
   EventCardList({super.key,required this.isPast});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return GestureDetector(
      onTap: () {
             Navigator.pushNamed(context, '/eventdetails');

      },
      child:  const EventCard(
          imageUrl: 'https://img.freepik.com/premium-photo/singer-performing-live-concert_954932-2255.jpg',
          title: 'Indie Vibes Night....',
          description: 'Experience raw, soulful sounds...',
          location: '3605 Parker Rd...',
          dateTime: '12 June 2025, 05:00 PM',
          isdetails:false
        ));
      },
    );
  }
}