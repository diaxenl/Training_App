import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_app/Basic_Employee/time_off.dart';
import 'package:training_app/Basic_Employee/warranty_swap.dart';
import 'package:training_app/web_view.dart';
import 'package:training_app/Basic_Employee/znet_home.dart';
import 'Basic_Employee/change_bat.dart';
import 'Basic_Employee/checkout.dart';
import 'Basic_Employee/wittdtjr.dart';
import 'package:training_app/Basic_Employee/test_bat.dart';
import 'Basic_Employee/replace_wiper_blades.dart';
import 'custom_page.dart';

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
    {'icon': Icons.create, 'text': 'Create New Page'}
  ];

  List<PageItem> items = []; // This will now include both your static and dynamic items

  @override
  void initState() {
    super.initState();
    _loadItems(); // Load both static and dynamic items
  }

  Future<void> _loadItems() async {
    // Define static items here. Each item has an icon, text, and a destination page.
    items = [
      PageItem(icon: Icons.battery_std, text: 'Change a Battery', destination: DetailPage(buttonText: 'Change a Battery',)),
      PageItem(icon: Icons.sell, text: 'WITTDTJR', destination: const WittdtjrPage()),
      PageItem(icon: Icons.clear, text: 'Replace Wiper Blades', destination: ChangeWiperBladePage(buttonText: 'Replace Wiper Blades')),
      PageItem(icon: Icons.alarm, text: 'Testing a Battery', destination: const BatteryTestingGuidePage(buttonText: 'Testing a Battery')),
      PageItem(icon: Icons.clear, text: 'Warranty Swap', destination: WarrantySwapPage(buttonText: 'Warranty Swap')),
      PageItem(icon: Icons.clear, text: 'Checkout', destination: CheckoutPage(buttonText: 'Checkout')),
      PageItem(icon: Icons.clear, text: 'Time Off', destination: TimeOffPage(buttonText: 'Time Off')),
      PageItem(icon: Icons.clear, text: 'ZNET', destination: ZnetHome(buttonText: 'ZNET')),
      PageItem(icon: Icons.clear, text: 'Website', destination: const WebViewPage(buttonText: 'Website')),
      PageItem(icon: Icons.create, text: 'Create New Page', destination: null), // No destination: handled specially
    ];

    // Load dynamic items from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    // Assuming you store each dynamic page with a unique key
    // For each key that represents a dynamic page, create a PageItem and add it to items
    // You'll need to adjust the logic based on how you store and identify these dynamic pages

    setState(() {
      // This will refresh the UI with the updated items
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded( // Expands to fill the available space, pushing the image to the center
              child: Container(), // Empty container used to center the title (image) when there's an action button
            ),
            Image.asset(
              'assets/images/az_logo.png',
              fit: BoxFit.contain,
              height: 50.0, // You can adjust the size of the image
            ),
            Expanded( // Expands to fill the available space, ensuring the image stays centered
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false, // Prevents the default back button from appearing
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Select an option below to get started:',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    elevation: 2.0,
                    child: InkWell(
                      onTap: () {
                        if (item.destination != null) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => item.destination!));
                        } else if (item.text == 'Create New Page') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LocalPageCreator()),
                          ).then((_) => _loadItems()); // Reload items upon returning, to refresh any new pages
                        }
                        // Add more conditions here if some items need special handling
                      },
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
              )
          ),
        ],
      ),
    );
  }
}

class PageItem {
  final IconData icon;
  final String text;
  final Widget? destination; // Widget to navigate to when this item is tapped

  PageItem({required this.icon, required this.text, this.destination});
}
