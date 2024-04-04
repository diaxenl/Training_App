import 'package:flutter/material.dart';
import 'Main_menu.dart';
import 'standard_training_home_page.dart'; // Import navigation.dart
import 'User_Stuff/user_login.dart';

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
          const UserLogin()
        //const MenuPage()
          //const TrainingHomePage(),
    );
  }
}
