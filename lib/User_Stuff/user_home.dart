import 'package:flutter/material.dart';
import 'package:training_app/standard_training_home_page.dart'; // Import for the training home page
import 'package:training_app/User_Stuff/quiz_page_1.dart'; // Import for quiz page 1
import 'package:training_app/User_Stuff/quiz_page_2.dart'; // Import for quiz page 2

// StatefulWidget for the UserHome page
class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  _UserHomeState createState() => _UserHomeState();
}

// State class for UserHome
class _UserHomeState extends State<UserHome> {
  final TextEditingController _searchController = TextEditingController(); // Controller for search input
  Widget? _searchResult; // Widget to display search results

  final bool _training1Completed = false; // Completion status for training 1
  final bool _training2Completed = false; // Completion status for training 2

  @override
  void dispose() {
    _searchController.dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate progress as the fraction of completed trainings
    int totalTrainings = 2;
    int completedTrainings = (_training1Completed ? 1 : 0) + (_training2Completed ? 1 : 0);
    double progress = completedTrainings / totalTrainings;

    return Scaffold(
      appBar: AppBar(
        title: buildAppBarTitle(context),
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      drawer: buildDrawer(context), // Drawer with navigation options
      body: buildBody(context, progress), // Main body of the page
    );
  }

  // AppBar title with navigation and logout functionality
  Widget buildAppBarTitle(BuildContext context) {
    return Row(
      children: <Widget>[
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        Expanded(child: Container()),
        Image.asset('assets/images/az_logo.png', height: 50.0),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }

  // Drawer with menu options
  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(child: Text('Menu')),
          ListTile(
            title: const Text('Item 1'),
            onTap: () => Navigator.pop(context), // Close the drawer on tap
          ),
          // Additional drawer items can be added here
        ],
      ),
    );
  }

  // Main content of the page with progress indicator and navigation buttons
  Widget buildBody(BuildContext context, double progress) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          LinearProgressIndicator(value: progress, backgroundColor: Colors.grey.shade300, color: Colors.orange, minHeight: 20),
          buildNavigationButton(context, 'Go to Training Home', const TrainingHomePage()),
          const SizedBox(height: 50),
          const Padding(padding: EdgeInsets.all(8.0), child: Text('Most Used Pages', style: TextStyle(fontSize: 20))),
          buildHorizontalList(context), // Horizontal list for page navigation
          const SizedBox(height: 50),
          buildSearchField(), // Search field for page navigation
          if (_searchResult != null) _searchResult!, // Display search result if available
        ],
      ),
    );
  }

  // Horizontal list to build navigation buttons for pages
  Widget buildHorizontalList(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _buildCardButton(context, 'Training 1', () => navigateToPage(context, const QuizPage1(userID: '')), _training1Completed),
          _buildCardButton(context, 'Training 2', () => navigateToPage(context, const QuizPage2(userID: '')), _training2Completed),
          // Additional buttons can be added here
        ],
      ),
    );
  }

  // Navigation button template
  Widget buildNavigationButton(BuildContext context, String buttonText, Widget destination) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => destination)),
          style: ElevatedButton.styleFrom(minimumSize: const Size(700, 50), textStyle: const TextStyle(fontSize: 24), backgroundColor: Colors.orange, foregroundColor: Colors.black),
          child: Text(buttonText),
        ),
      ),
    );
  }

  // Search field for finding pages
  Widget buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(hintText: 'Search for pages...', suffixIcon: Icon(Icons.search)),
        onSubmitted: _performSearch,
      ),
    );
  }

  // Card button used for navigation in the horizontal list
  Widget _buildCardButton(BuildContext context, String text, VoidCallback onTap, bool isCompleted) {
    return Card(
      elevation: 2.0,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(text), if (isCompleted) const Icon(Icons.check, color: Colors.green)],
            ),
          ),
        ),
      ),
    );
  }

  // Method to handle search actions
  void _performSearch(String query) {
    setState(() {
      _searchResult = buildNavigationButton(context, 'Go to "$query" page', const TrainingHomePage());
    });
  }

  // Method to navigate to a specific page
  void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
