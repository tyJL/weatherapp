import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'env/env.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => LocationState();

  void getCurrentLocation() {}
}

class LocationState extends State<Location> {
  String? _url;
  String? weatherData;
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<String?> getCurrentLocation() async {
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _url = "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=${Env.API_key}";
        print(_url);
      });
    }
          Response response = await get(Uri.parse(_url!));
          if (response.statusCode == 200) {
          setState(() {
            weatherData = jsonDecode(response.body).toString();
          });



    } else {
      setState(() {
        _url = "Please provide location permission";
      });
    }
    return weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _url ?? "Fetching location...",
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

