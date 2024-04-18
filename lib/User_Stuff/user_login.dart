import 'package:flutter/material.dart';
import 'package:training_app/standard_training_home_page.dart';
import './DatabaseHelper.dart';
import './user_model.dart'; // Make sure this points to your User model
import './DatabaseHelper.dart'; // Import your DatabaseHelper
import 'user_home.dart';
import 'package:training_app/in_between_guide.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    _users = await DatabaseHelper.instance.getUsers(); // Fetch users from the database
    setState(() {});
  }

  void _addUser(String firstName, String lastName, String pin) async {
    final user = User(firstName: firstName, lastName: lastName, pin: pin);
    await DatabaseHelper.instance.insertUser(user);
    _loadUsers();
  }

  void _showAddUserDialog() {
    final _firstNameController = TextEditingController();
    final _lastNameController = TextEditingController();
    final _pinController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false, // User must tap button to close dialog
      builder: (context) {
        return AlertDialog(
          title: Text('Add User',
              style: TextStyle(color: Theme.of(context).primaryColor)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                TextField(
                  controller: _pinController,
                  decoration: const InputDecoration(
                    labelText: 'PIN',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                _addUser(_firstNameController.text, _lastNameController.text,
                    _pinController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Login'),
        backgroundColor: Colors.orange,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0), // Adjust padding to prevent your list or content from being obscured by the fixed button.
            child: _users.isEmpty
                ? const Center(
              child: Text(
                'No users found. Tap "+" to add a user.',
                style: TextStyle(fontSize: 18),
              ),
            )
                : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(user.firstName[0]),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: const Text('Tap to login'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        // Call your method to delete the user
                        await DatabaseHelper.instance.deleteUser(user.firstName, user.lastName, user.pin);
                        _loadUsers(); // Reload the list to reflect the deletion
                      },
                    ),
                    onTap: () => _verifyPinAndNavigate(user),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InBetweenGuide()),
                      //MaterialPageRoute(builder: (context) => const TrainingHomePage()),
                    );
                  },
                  borderRadius: BorderRadius.circular(30.0),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    child: Center(
                      child: Text(
                        'Training Home',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 65.0),
        child: FloatingActionButton(
          onPressed: _showAddUserDialog,
          tooltip: 'Add User',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }



  void _verifyPinAndNavigate(User user) {
    final TextEditingController _pinController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter PIN'),
          content: TextField(
            controller: _pinController,
            decoration: const InputDecoration(labelText: 'PIN'),
            obscureText: true,
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_pinController.text == user.pin) {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserHome()),
                  );
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Incorrect PIN')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}