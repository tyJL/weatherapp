import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';




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