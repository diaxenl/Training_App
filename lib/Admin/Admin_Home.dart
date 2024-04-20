import 'package:flutter/material.dart';
import 'package:training_app/User_Stuff/user_model.dart';

//import 'package:training_app/User.dart';
import '../User_Stuff/DatabaseHelper.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    List<User> users =
        await DatabaseHelper.instance.getUsers(); // No casting needed
    print('Fetched users: $users'); // Debug: Print the users.
    if (users.length > 1) {
      setState(() {
        _users = users.sublist(1); // Assuming the first user is the admin
      });
    }
  }

  void _showEditUserDialog(User user) {
    final _firstNameController = TextEditingController(text: user.firstName);
    final _lastNameController = TextEditingController(text: user.lastName);
    final _pinController = TextEditingController(text: user.pin);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit User'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                ),
                TextField(
                  controller: _pinController,
                  decoration: const InputDecoration(labelText: 'PIN'),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () async {
                if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty || _pinController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('All fields are required!'))
                  );
                  return;
                }

                try {
                  // Cast or confirm user.id is an integer
                  int userId = int.tryParse(user.pin.toString()) ?? 0;
                  if (userId == 0) {
                    throw 'Invalid user ID'; // Add more robust handling as needed
                  }

                  await DatabaseHelper.instance.updateUserDetails(
                    userId,
                    _firstNameController.text.trim(),
                    _lastNameController.text.trim(),
                    _pinController.text.trim(),
                  );

                  _loadUsers();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User updated successfully!'))
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update user: $e'))
                  );
                }
              },

            ),

          ],
        );
      },
    );
  }


  Widget _buildPopupMenu(User user) {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        switch (result) {
          case 'edit':
            _showEditUserDialog(user);
            break;
          case 'delete':
            DatabaseHelper.instance.deleteUser(user.firstName, user.lastName, user.pin);
        _loadUsers();
            break;
          default:
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'edit',
          child: Text('Edit'),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          User user = _users[index];
          bool isTrainingCompleted =
              user.quiz1Completed == 1 && user.quiz2Completed == 1;
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(user.firstName[0] + user.lastName[0]),
              ),
              title: Text('${user.firstName} ${user.lastName}'),
              subtitle: Text(
                isTrainingCompleted ? 'Training Completed' : 'Training Pending',
                style: TextStyle(
                    color: isTrainingCompleted ? Colors.green : Colors.red),
              ),
              trailing: _buildPopupMenu(user),
            ),
          );
        },
      ),
    );
  }
}
