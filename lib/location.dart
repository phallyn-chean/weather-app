import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late LocationData _currentLocation = LocationData.fromMap({});
  String _address = '';
  Location location = Location();

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  void fetchLocation() async {
    Future<List<Address>> getAddress(double? lat, double? lang) async {
      final coordinates = Coordinates(lat, lang);
      List<Address> address = await Geocoder.local.findAddressesFromCoordinates(coordinates);

      return address;
    }

    bool _servicesEnabled;
    PermissionStatus _permisionGranted;

    _servicesEnabled = await location.serviceEnabled();
    if (_servicesEnabled) {
      _servicesEnabled = await location.requestService();
      if (!_servicesEnabled) {
        return;
      }
    }

    _permisionGranted = await location.hasPermission();
    if (_permisionGranted == PermissionStatus.denied) {
      _permisionGranted == await location.requestPermission();
      if (_permisionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentLocation = await location.getLocation();
    location.onLocationChanged.listen((currentLocation) {
      setState(() {
        _currentLocation = currentLocation;
        getAddress(_currentLocation.latitude, _currentLocation.longitude).then((value) {
          setState(() {
            _address = "${value.first.addressLine}";
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Longtitude: ${_currentLocation.longitude ?? 0}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            Text(
              "Latitude: ${_currentLocation.latitude ?? 0}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            if (_address.isNotEmpty)
              Text(
                "Address: $_address",
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
