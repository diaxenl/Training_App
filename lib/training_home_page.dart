import 'package:flutter/material.dart';
import 'package:training_app/time_off.dart';
import 'package:training_app/warranty_swap.dart';
import 'package:training_app/web_view.dart'; // Assuming this is correctly pointing to your WebViewPage
import 'package:training_app/znet_home.dart';
import 'change_bat.dart'; // Assuming this is correctly pointing to your BatteryTestingGuidePage
import 'checkout.dart';
import 'wittdtjr.dart'; // Assuming this is correctly pointing to your WittdtjrPage
import 'test_bat.dart'; // Assuming this is your custom page, ensure it's correctly imported
import 'replace_wiper_blades.dart'; // Assuming this is correctly pointing to your ChangeWiperBladePage

class TrainingHomePage extends StatefulWidget {
  const TrainingHomePage({Key? key}) : super(key: key);

  @override
  _TrainingHomePageState createState() => _TrainingHomePageState();
}

class _TrainingHomePageState extends State<TrainingHomePage> {
  final List<Map<String, dynamic>> buttonData = [
    {'icon': Icons.battery_std, 'text': 'Change a Battery'},
    {'icon': Icons.sell, 'text': 'WITTDTJR'},
    {'icon': Icons.clear, 'text': 'Replace Wiper Blades'},
    {'icon': Icons.alarm, 'text': 'Testing a Battery'},
    {'icon': Icons.phone, 'text': 'Warranty Swap'},
    {'icon': Icons.camera_alt, 'text': 'Checkout'},
    {'icon': Icons.favorite, 'text': 'Time Off'},
    {'icon': Icons.email, 'text': 'ZNET'},
    {'icon': Icons.map, 'text': 'Website'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training App'),
        toolbarHeight: 180.0, // Increased height
        leading: null
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
                    onTap: () => _onButtonTap(context, index),
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

  void _onButtonTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Change a Battery
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    buttonText: 'Change a Battery',
                  )),
        );
        break;
      case 1:
        // WITTDTJR
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WittdtjrPage()),
        );
        break;
      case 2:
        // Replace Wiper Blades
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeWiperBladePage(
                    buttonText: 'Change Wiper Blade',
                  )), // Ensure this is the correct constructor
        );
        break;
      case 3:
        // Testing a Battery
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const BatteryTestingGuidePage()), // Ensure this is the correct constructor
        );
        break;
      case 4:
        // MISSING
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WarrantySwapPage(
                    buttonText: 'Warranty Swap',
                  )), // Ensure this is the correct constructor
        );
        break;
      case 5:
        // MISSING
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckoutPage(
                    buttonText: 'Checkout',
                  )), // Ensure this is the correct constructor
        );
        break;
      case 6:
        // MISSING
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TimeOffPage(
                    buttonText: 'Time Off',
                  )), // Ensure this is the correct constructor
        );
        break;
      case 7:
        // MISSING
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ZnetHome()), // Ensure this is the correct constructor
        );
        break;
      case 8:
        // Website
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const WebViewPage(buttonText: 'Web View')),
        );
        break;
      default:
        // Handle other cases or default navigation
        break;
    }
  }
}
