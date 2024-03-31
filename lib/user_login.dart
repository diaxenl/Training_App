import 'package:flutter/material.dart';
import 'package:training_app/standard_training_home_page.dart';
import 'DatabaseHelper.dart';
import 'user_model.dart'; // Make sure this points to your User model
import 'DatabaseHelper.dart'; // Import your DatabaseHelper

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  List<User> _users = []; // This will now hold users loaded from the database

  @override
  void initState() {
    super.initState();
    _loadUsers(); // Load users from the database when the widget initializes
  }

  void _loadUsers() async {
    _users = await DatabaseHelper.instance.getUsers(); // Fetch users from the database
    setState(() {}); // Update the UI
  }

  void _addUser(String firstName, String lastName, String pin) async {
    final user = User(firstName: firstName, lastName: lastName, pin: pin);
    await DatabaseHelper.instance.insertUser(user); // Insert the user into the database
    _loadUsers(); // Reload users to update the UI
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
      body: _users.isEmpty
          ? const Center(
              child: Text(
                'No users found. Tap "+" to add a user.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.separated(
              itemCount: _users.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final user = _users[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(user.firstName[0]),
                  ),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: const Text('Tap to login'),
                  onTap: () => _verifyPinAndNavigate(user),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddUserDialog,
        tooltip: 'Add User',
        child: const Icon(Icons.add),
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
                        builder: (context) => const TrainingHomePage()),
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
