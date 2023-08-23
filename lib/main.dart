import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'env/env.dart';
import 'package:go_router/go_router.dart';
import 'weather.dart';
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
          return const MaterialPage(child: WeatherPage(url: ''));

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



class PrognosisPage extends StatelessWidget {
  const PrognosisPage({Key? key, required this.prognosisData}) : super(key: key);
  final List<Map> prognosisData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('The Weather App'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: prognosisData.length,
              itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(prognosisData[index] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(color: Colors.red, thickness:1.0);
              },
            ),
          ),
        ],
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

class WeatherPage extends StatefulWidget {
  const WeatherPage({ super.key, required this.url});
  // final String? weatherData;
  final String? url;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String? _url;
  Weather? weather;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }



  Future<void> getCurrentLocation() async {
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _url = "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=${Env.API_key}";
        // "Latitude: ${position.latitude},\n"
        // "Longitude: ${position.longitude}";

      });
    } else {
      setState(() {
        _url = "Please provide location permission";

      });
    }


    Future<void> fetchJsonData(String url) async {


      final response = await get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          weather = Weather.fromJson(json.decode(response.body));
        });
      } else {
          throw Exception('Failed to load JSON data');
      }
      print(weather!);
    }
    fetchJsonData(_url!);
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
            Text(_url ?? "funkar inte för tillfället...",
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


class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('The Weather App'),
        ),
      ),      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Project Weather App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text("This if the app developed for the course \n"
            " 1DV535 at Linnaeus University by using\n"
                "Flutter and OpenWeatherMap's API.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20
              ),
            ),
            SizedBox(height: 20),
            Text("The app is developed by \n"
                " Conny Andersson",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
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