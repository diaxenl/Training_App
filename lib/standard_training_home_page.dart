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
import 'User_Stuff/user_login.dart';
import 'custom_page.dart';

///Page that contains all cards to all pages. Easily scalable with the list of pages.
class TrainingHomePage extends StatefulWidget {
  const TrainingHomePage({Key? key}) : super(key: key);

  @override
  _TrainingHomePageState createState() => _TrainingHomePageState();
}

///List of all current pages, used to generate page content (deprecated)
class _TrainingHomePageState extends State<TrainingHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  List<PageItem> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  ///List of all pages, name, and destination. Used to populate the card grid with data.
  Future<void> _loadItems() async {
    items = [
      PageItem(icon: Icons.battery_std, text: 'Change a Battery', destination: DetailPage(buttonText: 'Change a Battery',)),
      PageItem(icon: Icons.sell, text: 'WITTDTJR', destination: const WittdtjrPage()),
      PageItem(icon: Icons.build, text: 'Replace Wiper Blades', destination: ChangeWiperBladePage(buttonText: 'Replace Wiper Blades')),
      PageItem(icon: Icons.battery_alert, text: 'Testing a Battery', destination: const BatteryTestingGuidePage(buttonText: 'Testing a Battery')),
      PageItem(icon: Icons.swap_horiz, text: 'Warranty Swap', destination: WarrantySwapPage(buttonText: 'Warranty Swap')),
      PageItem(icon: Icons.payment, text: 'Checkout', destination: CheckoutPage(buttonText: 'Checkout')),
      PageItem(icon: Icons.beach_access, text: 'Time Off', destination: TimeOffPage(buttonText: 'Time Off')),
      PageItem(icon: Icons.network_check, text: 'ZNET', destination: ZnetHome(buttonText: 'ZNET')),
      PageItem(icon: Icons.web, text: 'Website', destination: const WebViewPage(buttonText: 'Website')),
      PageItem(icon: Icons.create, text: 'Create New Page', destination: null), // No destination: handled specially
    ];

    // Load dynamic items from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    // Assuming you store each dynamic page with a unique key
    // For each key that represents a dynamic page, create a PageItem and add it to items
    // You'll need to adjust the logic based on how you store and identify these dynamic pages
    // Beginning of refactoring to improve scalability, searchability and allow user generated content

    setState(() {
      // This will refresh the UI with the updated items
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Row(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/az_logo.png',
                  fit: BoxFit.contain,
                  height: 50.0,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const UserLogin()),
                );
              },
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            print('Drawer button pressed');
            if (_scaffoldKey.currentState != null) {
              _scaffoldKey.currentState!.openDrawer();
            } else {
              print('Drawer key state is null');
            }
          },
        ),
      ),
      drawer: buildDrawer(context),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  child: InkWell(
                    onTap: () {
                      if (item.destination != null) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => item.destination!));
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(item.icon, size: 50),
                        Text(item.text, textAlign: TextAlign.center),
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

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(child: Text('Menu')),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              // Add futute actions here
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => UserLogin()),
              );
            },
          ),
        ],
      ),
    );
  }
}


class PageItem {
  final IconData icon;
  final String text;
  final Widget? destination;

  PageItem({required this.icon, required this.text, this.destination});
}
