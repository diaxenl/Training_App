import 'package:flutter/material.dart';
import 'Main_menu.dart';
import 'standard_training_home_page.dart';
import 'User_Stuff/user_login.dart';

void main() {
  /// This is generally what would be needed to get storage permissions but I don't know if the tablet
  /// I got access to is the issue or something else. A nice post semester problem I dare say.
  //  WidgetsFlutterBinding.ensureInitialized();
  //
  //   // Request essential permissions upfront
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.storage,
  //     // Add other permissions as needed
  //   ].request();
  //
  //   print("Permission statuses: $statuses");
  //
  //   runApp(const TrainingApp());

  runApp(const TrainingApp());
}

/// Defines entry point
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
