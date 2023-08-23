import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'env/env.dart';
import 'package:go_router/go_router.dart';
import 'weatherData.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({ super.key});
  // final String? weatherData;


  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String? url;
  WeatherData? weather;
  List<String?> test = [];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<WeatherData?> fetchJsonData(String url) async {

    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        weather = WeatherData.fromJson(json.decode(response.body));
        print(weather!.icon);
      });
    } else {
      throw Exception('Failed to load JSON data');
    }
    return weather;
  }


  Future<WeatherData?> getCurrentLocation() async {
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        url = "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=${Env.API_key}";
        print(url);
      });
    } else {
      setState(() {
        url = "Please provide location permission";

      });
      return fetchJsonData(url!);
    }




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(
        child: Text('The Weather App'),
        ),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 30),
            Text(url! ?? "Fetching location...",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          color: Colors.red,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => context.go('/weather'),
                  icon: const Icon(
                      Icons.cloud
                  ),
                ),
                IconButton(
                  onPressed: () => context.go('/'),
                  icon: const Icon(
                      Icons.home
                  ),
                ),
                IconButton(
                  onPressed: () => context.go('/about'),
                  icon: const Icon(
                      Icons.info
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
