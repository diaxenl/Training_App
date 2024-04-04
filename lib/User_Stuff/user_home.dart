import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:training_app/standard_training_home_page.dart'; // Adjust this import path to where your TrainingHomePage is located.

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final TextEditingController _searchController = TextEditingController();
  Widget? _searchResult;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Image.asset(
              'assets/images/az_logo.png',
              fit: BoxFit.contain,
              height: 50.0,
            ),
            Expanded(
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
        automaticallyImplyLeading: false,
      ),
      drawer: Drawer(
        // Add items to your drawer here, such as profile, settings, etc.
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                //color: Colors.orange,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            // Add more items here
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const TrainingHomePage()), // Update this to your training home page navigation
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(700, 50),
                        textStyle:
                        const TextStyle(fontSize: 24, color: Colors.black),
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.black),
                    child: const Text('Go to Training Home'),
                  ),
                )),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Most Used Pages', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(
              height: 100.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildCardButton(context, 'Page 1', () {}),
                  _buildCardButton(context, 'Page 2', () {}),
                  // Add more as needed
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Training to Complete', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(
              height: 100.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildCardButton(context, 'Training 1', () {}),
                  _buildCardButton(context, 'Training 2', () {}),
                  // Add more as needed
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search for pages...',
                  suffixIcon: Icon(Icons.search),
                ),
                onSubmitted: _performSearch,
              ),
            ),
            if (_searchResult != null) _searchResult!, // Display the search result if it's not null
          ],
        ),
      ),
    );
  }

  Widget _buildCardButton(BuildContext context, String text, VoidCallback onTap) {
    return Card(
      elevation: 2.0,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 120, // Adjust width as needed
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }

  void _performSearch(String query) {
    // Here you would typically check if the query matches available pages
    // and set the result accordingly. For simplicity, this example
    // will just create a button that says "Go to [searched term] page"
    // and navigates to the TrainingHomePage.
    setState(() {
      _searchResult = Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            // Logic to navigate to the searched page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TrainingHomePage()),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(700, 50),
            textStyle: const TextStyle(fontSize: 24, color: Colors.black),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.black,
          ),
          child: Text('Go to "$query" page'),
        ),
      );
    });
  }


}
