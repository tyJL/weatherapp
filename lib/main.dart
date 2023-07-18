import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
// import 'location.dart';

void main() {

  final goRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(child: IntroPage());

        },
      ),
      GoRoute(
        path: '/weather',
        pageBuilder: (context, state) {
          return MaterialPage(child: WeatherPage());

        },
      ),
      GoRoute(
        path: '/about',
        pageBuilder: (context, state) {
          return MaterialPage(child: AboutPage());
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




abstract class Page extends StatefulWidget {
  Page({super.key});
}

class IntroPage extends Page {
   IntroPage({super.key});

  @override
  State<Page> createState() => _IntroPageState();

}

class _IntroPageState extends State<Page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intro Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            GoRouter.of(context).go('/weather');
          },
          child: const Text('Go to Weather Page'),
        ),
      ),
    );
  }


}

class WeatherPage extends Page {
  WeatherPage({super.key});


  @override
  State<Page> createState() => _WeatherPageState();

}

class _WeatherPageState extends State<Page> {

  var message = "ej fixat än";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You've reached the Weather page"),
            const SizedBox(height: 20),
            Text(message!),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/about');
              },
              child: const Text('Go back to About Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends Page {
  AboutPage({super.key});

  @override
  State<Page> createState() => _AboutPageState();

  }

class _AboutPageState extends State<Page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You've reached the About page"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/');
                 },
              child: const Text('Go back to First Page'),
            ),
          ],
        ),
      ),
    );
  }
}



class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => LocationState();
}

class LocationState extends State<Location> {
  String? locationMessage;

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
        locationMessage =
        "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
      });
    } else {
      setState(() {
        locationMessage = "Please provide location permission";
      });
    }
  }
  String? getLocation() {
    return locationMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          locationMessage ?? "Fetching location...",
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}


