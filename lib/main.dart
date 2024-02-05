import 'package:flutter/material.dart';
import 'detail_page.dart';

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
    {'icon': Icons.search, 'text': 'Button 2'},
    {'icon': Icons.settings, 'text': 'Button 3'},
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
        toolbarHeight: 180.0, // Increase the AppBar's height
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 items per row
          crossAxisSpacing: 10.0, // Horizontal space between items
          mainAxisSpacing: 10.0, // Vertical space between items
        ),
        itemCount: buttonData.length, // Total number of items
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisSize: MainAxisSize.min, // Use minimum space
            children: <Widget>[
              IconButton(
                icon: Icon(buttonData[index]['icon']),
                iconSize: 50,
                onPressed: () {
                  // Navigate to the DetailPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailPage(buttonText: buttonData[index]['text'])),
                  );
                },
              ),

              Text(buttonData[index]['text']), // Text description below the icon
            ],
          );
        },
      ),
    );
  }
}
