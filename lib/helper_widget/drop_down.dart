import 'package:flutter/material.dart';

class StateDropdown extends StatefulWidget {
  @override
  _StateDropdownState createState() => _StateDropdownState();
}

class _StateDropdownState extends State<StateDropdown> {
  String? selectedState;

  final List<String> states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedState,
      decoration: const InputDecoration(
        labelText: 'Select State',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      icon: Icon(Icons.arrow_drop_down),
      isExpanded: true,
      items: states.map((String state) {
        return DropdownMenuItem<String>(
          value: state,
          child: Text(state),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedState = newValue!;
        });
      },
    );
  }
}
