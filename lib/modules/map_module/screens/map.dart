import 'package:flutter/material.dart';
import 'package:found_soul_mobile_app/helper_widget/appbar.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  // Default position before fetching data
  final LatLng _initialPosition = const LatLng(20.5937, 78.9629); // Center of India

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar:  CustomAppBar(title: "Map", showBackButton: false,actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: AppTheme.textPrimary),
            onPressed: () => Navigator.pushNamed(context, '/notification'),
          ),
        ],),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 5,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
          _fetchPinsFromFirebase(); // fetch pins only after map is ready
        },
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }

  Future<void> _fetchPinsFromFirebase() async {
    final ref = FirebaseDatabase.instance.ref("locations");
    final snapshot = await ref.get();

    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);

      for (var entry in data.entries) {
        final pin = Map<String, dynamic>.from(entry.value);

        final marker = Marker(
          markerId: MarkerId(entry.key),
          position: LatLng(
            pin['latitude'],
            pin['longitude'],
          ),
          infoWindow: InfoWindow(
            title: pin['title'] ?? "No Title",
          ),
        );

        _markers.add(marker);
      }

      setState(() {}); // Refresh UI with markers

      // Move camera to first pin location (optional)
      if (_markers.isNotEmpty) {
        final first = _markers.first.position;
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(first, 12),
        );
      }
    }
  }
}
