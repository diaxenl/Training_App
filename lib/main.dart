import 'package:flutter/material.dart';
import 'training_home_page.dart'; // Import navigation.dart

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
      home:
          const TrainingHomePage(), // Use TrainingHomePage from navigation.dart
    );
  }
}
import 'package:flutter/material.dart';
import 'training_home_page.dart'; // Import navigation.dart

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
      home:
          const TrainingHomePage(), // Use TrainingHomePage from navigation.dart
    );
  }
}
