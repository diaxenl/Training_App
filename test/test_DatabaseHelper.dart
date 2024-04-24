import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:training_app/User_Stuff/DatabaseHelper.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  group('DatabaseHelper Tests', () {
    MockDatabase mockDatabase;
    DatabaseHelper dbHelper;

    setUp(() {
      mockDatabase = MockDatabase();
      dbHelper = DatabaseHelper.; // Ensure you have access to this in your implementation
      dbHelper.database = mockDatabase;  // Assume `database` is injectable for testing
    });

    test('Insert user', () async {
      when(mockDatabase.insert(any, any)).thenAnswer((_) async => 1);  // Simulating inserting a user
      expect(await dbHelper.insertUser(User(...)), 1);  // Adjust based on your method signatures
    });

    // Additional tests here
  });
}
