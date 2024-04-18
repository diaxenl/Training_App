import 'package:flutter/material.dart';
import 'standard_training_home_page.dart';

class InBetweenGuide extends StatelessWidget {
  final List<NavigationItem> navigationItems = [
    NavigationItem(icon: Icons.settings, text: 'Processes', destination: const TrainingHomePage()),
    NavigationItem(icon: Icons.build, text: 'Problems and solutions', destination: const TrainingHomePage()),
    NavigationItem(icon: Icons.model_training, text: 'training', destination: const TrainingHomePage()),
    NavigationItem(icon: Icons.view_comfy, text: 'All', destination: const TrainingHomePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Category'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: navigationItems.length,
                itemBuilder: (context, index) {
                  final item = navigationItems[index];
                  return Card(
                    elevation: 2.0,
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => item.destination)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(child: Icon(item.icon, size: 50)),
                          Text(item.text, textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String text;
  final Widget destination;

  NavigationItem({required this.icon, required this.text, required this.destination});
}
