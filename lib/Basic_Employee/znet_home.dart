import 'package:flutter/material.dart';

// Import pages that you will navigate to. For now, these are placeholders.
// Make sure to update these imports to the actual pages you want to navigate to.
import 'package:training_app/standard_training_home_page.dart'; // Assuming you have a back navigation for demonstration.

class ZnetHome extends StatelessWidget {
  ZnetHome({Key? key}) : super(key: key);

  // Define button details here. Each map in the list represents a button.
  // For now, it contains a placeholder for where the button should navigate to.
  // You'll replace 'TrainingHomePage()' with the actual page you want to navigate to.
  final List<Map<String, dynamic>> buttonDetails = [
    {'text': 'Function 1', 'destination': const TrainingHomePage()},
    {'text': 'Function 2', 'destination': const TrainingHomePage()},
    {'text': 'Function 3', 'destination': const TrainingHomePage()},
    {'text': 'Function 4', 'destination': const TrainingHomePage()},
    {'text': 'Function 5', 'destination': const TrainingHomePage()},
    {'text': 'Function 6', 'destination': const TrainingHomePage()},
    {'text': 'Function 7', 'destination': const TrainingHomePage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Znet Home'),
        toolbarHeight: 180.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Here we will go over how to navigate Znet and its various functions',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset('assets/images/znet_guide.png'),
            // Ensure you have this image in your assets
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // to disable GridView's scrolling
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1, // Makes grid items square
              ),
              padding: const EdgeInsets.all(10),
              itemCount: buttonDetails.length,
              itemBuilder: (context, index) {
                return GridTile(
                  child: InkWell(
                    onTap: () {
                      // Navigate to the destination specified in buttonDetails for this button
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              buttonDetails[index]['destination']));
                    },
                    child: Container(
                      color: Colors.blue, // Button background color
                      child: Center(
                        child: Text(
                          buttonDetails[index]['text'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
