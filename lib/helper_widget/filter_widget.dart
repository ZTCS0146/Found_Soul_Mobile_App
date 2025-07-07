import 'package:flutter/material.dart';

class FilterTile extends StatelessWidget {
  final String title;
  const FilterTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
        onTap: () {},
      ),
    );
  }
}