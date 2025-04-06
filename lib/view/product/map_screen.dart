import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:digital_kabaria_app/Utils/app_colors.dart';

class MapScreen extends StatefulWidget {
  final double lat;
  final double lng;

  const MapScreen({Key? key, required this.lat, required this.lng}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng initialLatLng;
  LatLng? currentLatLng;
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    initialLatLng = LatLng(widget.lat, widget.lng);
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentLatLng = LatLng(position.latitude, position.longitude);
      _addMarkers();
      _addPolyline();
      _moveCamera();
    });
  }

  void _addMarkers() {
    if (currentLatLng != null) {
      _markers.addAll([
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: currentLatLng!,
          infoWindow: const InfoWindow(title: "Your Location"),
        ),
        Marker(
          markerId: const MarkerId("destination"),
          position: initialLatLng,
          infoWindow: const InfoWindow(title: "Destination"),
        ),
      ]);
    }
  }

  void _addPolyline() {
    if (currentLatLng != null) {
      _polylines.add(Polyline(
        polylineId: const PolylineId("route"),
        points: [currentLatLng!, initialLatLng],
        color: Colors.blue,
        width: 5,
      ));
    }
  }

  void _moveCamera() {
    if (_mapController != null && currentLatLng != null) {
      LatLngBounds bounds;
      if (currentLatLng!.latitude > initialLatLng.latitude &&
          currentLatLng!.longitude > initialLatLng.longitude) {
        bounds = LatLngBounds(southwest: initialLatLng, northeast: currentLatLng!);
      } else {
        bounds = LatLngBounds(southwest: currentLatLng!, northeast: initialLatLng);
      }
      _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialLatLng,
              zoom: 14.0,
            ),
            polylines: _polylines,
            markers: _markers,
            onMapCreated: (controller) {
              _mapController = controller;
              _moveCamera(); 
            },
            myLocationEnabled: true,
          ),
        ],
      ),
    );
  }
}
