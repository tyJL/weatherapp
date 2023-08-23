import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


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
          Padding(padding: EdgeInsets.all(20),
            child: Text("This if the app developed for the\n"
                        "course 1DV535 at Linnaeus\n"
                        "University by using Flutter and\n"
                        "OpenWeatherMap's API.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
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