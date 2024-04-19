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
          title: Text('Edit User'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
                TextField(
                  controller: _pinController,
                  decoration: InputDecoration(labelText: 'PIN'),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                // Assuming you have methods in your DatabaseHelper to update these details
                DatabaseHelper.instance.updateUserDetails(
                  user.pin as int, // Assuming your User model has an 'id' field
                  _firstNameController.text,
                  _lastNameController.text,
                  _pinController.text,
                ).then((_) {
                  // Reload the updated data
                  _loadUsers();
                  Navigator.of(context).pop(); // Close the dialog
                });
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
            // Your existing delete user logic
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
