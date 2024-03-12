import 'package:flutter/material.dart';
import 'standard_training_home_page.dart'; // Import for navigation

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: LayoutBuilder(
          // Use LayoutBuilder for dynamic sizing
          builder: (BuildContext context, BoxConstraints constraints) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(20), // Adjust padding as needed
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (1 / .8),
                  // Adjust based on your content
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  // Use shrinkWrap to fit the content in the viewport
                  physics: const NeverScrollableScrollPhysics(),
                  // Disables scrolling
                  children: <Widget>[
                    // New Employee Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TrainingHomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Button color
                        minimumSize: const Size(100, 100), // Size of the button
                        shape: RoundedRectangleBorder(
                          // Rounded corners
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'New Employee',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ),
                    // Manager Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TrainingHomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(100, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Manager',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ),
                    // Commercial Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TrainingHomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(100, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Commercial',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ),
                    // Store Manager Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TrainingHomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: const Size(100, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Store Manager',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
