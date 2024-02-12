import 'package:flutter/material.dart';
import 'change_bat.dart';
import 'wittdtjr.dart';
import 'test_bat.dart';
import 'replace_wiper_blades.dart';

void main() {
  runApp(const TrainingApp());
}

class TrainingApp extends StatelessWidget {
  const TrainingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Training App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TrainingHomePage(),
    );
  }
}

class TrainingHomePage extends StatefulWidget {
  const TrainingHomePage({super.key});

  @override
  _TrainingHomePageState createState() => _TrainingHomePageState();
}

class _TrainingHomePageState extends State<TrainingHomePage> {
  final List<Map<String, dynamic>> buttonData = [
    {'icon': Icons.battery_std, 'text': 'Change a Battery'},
    {'icon': Icons.sell, 'text': 'WITTDTJR'},
    {'icon': Icons.clear, 'text': 'Replace Wiper Blades'},
    {'icon': Icons.alarm, 'text': 'Button 4'},
    {'icon': Icons.phone, 'text': 'Button 5'},
    {'icon': Icons.camera_alt, 'text': 'Button 6'},
    {'icon': Icons.favorite, 'text': 'Button 7'},
    {'icon': Icons.email, 'text': 'Button 8'},
    {'icon': Icons.map, 'text': 'Button 9'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training App'),
        toolbarHeight: 180.0, // Increased height
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Select an option below to get started:',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 items per row
                crossAxisSpacing: 10.0, // Horizontal space between items
                mainAxisSpacing: 10.0, // Vertical space between items
              ),
              itemCount: buttonData.length, // Total number of items
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 2.0, // Add elevation for shadow
                  child: InkWell(
                    onTap: () {
                      if (index == 0) {
                        //Change bat
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BatteryTestingGuidePage()),
                        );
                      } else if (index == 1) {
                        // Navigation to WittdtjrPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WittdtjrPage()),
                        );
                      } else if (index == 2) {
                        // Navigation to test_bat
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeWiperBladePage(
                                    buttonText: 'Change Wiper Blades',
                                  )),
                        );
                      } else if (index == 3) {
                        // Navigation to replace_wiper_blade
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeWiperBladePage(
                                    buttonText: 'Change Wiper Blades',
                                  )),
                        );
                      } else {
                        // Default case for other buttons
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  buttonText: buttonData[index]['text'])),
                        );
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Use minimum space
                      children: <Widget>[
                        Expanded(
                          child: Icon(
                            buttonData[index]['icon'],
                            size: 50, // Icon size
                          ),
                        ),
                        Text(
                          buttonData[index]['text'],
                          // Text description below the icon
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
