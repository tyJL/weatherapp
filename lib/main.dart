import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weatherapp/weather.dart';
import 'about.dart';
import 'env/env.dart';
import 'package:go_router/go_router.dart';
import 'weatherData.dart';
import 'prognosis.dart';
// import 'weather.dart';
void main() {

  final goRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: PrognosisPage(prognosisData: [],));

        },
      ),
      GoRoute(
        path: '/weather',
        pageBuilder: (context, state) {
          return const MaterialPage(child: WeatherPage());

        },
      ),
      GoRoute(
        path: '/about',
        pageBuilder: (context, state) {
          return const MaterialPage(child: AboutPage());
        },
      ),
    ],
  );

  runApp(MyApp(goRouter: goRouter));
}




class MyApp extends StatelessWidget {
  final GoRouter goRouter;

  const MyApp({Key? key, required this.goRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'The Weather App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

PrognosisPage prognosis = const PrognosisPage(prognosisData: []);

WeatherPage weather = const WeatherPage();

AboutPage about = const AboutPage();



// class Location extends StatefulWidget {
//   const Location({super.key});
//
//   @override
//   State<Location> createState() => _LocationState();
// }
//
// class _LocationState extends State<Location> {
//
//   String? _url;
//   @override
//   void initState() {
//     super.initState();
//     getCurrentLocation();
//   }
//
//   Future<String?> getCurrentLocation() async {
//     PermissionStatus permissionStatus = await Permission.location.request();
//
//     if (permissionStatus.isGranted) {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       setState(() {
//         _url = "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=${Env.API_key}";
//         // "Latitude: ${position.latitude},\n"
//         // "Longitude: ${position.longitude}";
//         print(_url);
//       });
//     } else {
//       setState(() {
//         _url = "Please provide location permission";
//
//       });
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Location Finder')),
//       body: Center(
//         child: Text(
//           _url ?? "Fetching location...",
//           style: const TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }