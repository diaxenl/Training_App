import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPageCreator extends StatefulWidget {
  const LocalPageCreator({super.key});

  @override
  _LocalPageCreatorState createState() => _LocalPageCreatorState();
}

class _LocalPageCreatorState extends State<LocalPageCreator> {
  String _title = '';
  String _content = '';

  get key_title => null;

  get key_content => null;

  // Simplified _saveData method without image handling
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    // Generate a unique key for each new page (e.g., using timestamp)
    String key = "page_${DateTime.now().millisecondsSinceEpoch}";
    await prefs.setString('$key_title', _title);
    await prefs.setString('$key_content', _content);

    // After saving, navigate back to the previous screen
    Navigator.pop(context, true); // Passing `true` to indicate that a save was made
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) => _title = value,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              onChanged: (value) => _content = value,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 3, // Allow multiple lines for content
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveData,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}