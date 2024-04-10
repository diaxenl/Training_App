import 'package:flutter/material.dart';
import 'change_bat.dart';

class BatteryTestingGuidePage extends StatelessWidget {
  const BatteryTestingGuidePage({Key? key, required String buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('buttonText'),
        toolbarHeight: 180.0, // Increased height
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        // Allows the page to be scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              leading: Icon(Icons.access_time, color: Colors.blue),
              title: Text('2-4 min/Easy Difficulty',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('What You Need',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const Text('1. Battery Tester'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Expanded(child: Text('2. Computer or Tester Dock')),
                  Image.asset('assets/tester_dock_image.png', width: 100),
                  // Example image, replace with your actual asset
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Introduction',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const Text(
                'Battery testing is a service offered by AutoZone and is a fairly simple process. This can be done on or off the vehicle. DO NOT TEST SMALL BATTERIES (Motorcycle, ATV, etc.)'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Step 1',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const Text(
                'Power on the battery tester, hook up the cables to the correct terminals, red to positive (+) and black to negative (-).'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Step 2',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const Text(
                'Locate the cold cranking amps (CCA) value and enter this into the tester (or note it for later depending on your model). Start the test and follow the on screen instructions.'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Step 3',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const Text(
                'When the test is finished place the battery tester back into its dock. For basic information select the most recent test, a results receipt can be printed for the customer from here. For detailed information the results can be looked up at the computer under Diagnostic Reports on the left side of the ZNet homescreen.'),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(
                            buttonText: '',
                          )), // Update this with the correct constructor based on your DetailPage
                ),
                child: const Text('Learn More'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
