import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_app/User_Stuff/user_login.dart'; // Adjust the path as necessary
import 'package:training_app/User_Stuff/DatabaseHelper.dart'; // Adjust the path as necessary

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  group('UserLogin Page Tests', () {
    MockDatabaseHelper mockDatabaseHelper;

    setUp(() {
      mockDatabaseHelper = MockDatabaseHelper();
    });

    testWidgets('UI Elements and Initial State', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: UserLogin()));

      // Check for UI elements presence
      expect(find.byType(TextField), findsNWidgets(2)); // Assuming there are two text fields
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Form Input and Validation', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: UserLogin()));

      // Simulate user input
      await tester.enterText(find.byType(TextField).at(0), ''); // Username
      await tester.enterText(find.byType(TextField).at(1), ''); // Password
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Check for error messages
      expect(find.text('Please enter a username'), findsOneWidget);
      expect(find.text('Please enter a password'), findsOneWidget);
    });

    testWidgets('Successful Login and Navigation', (WidgetTester tester) async {
      await tester.enterText(find.byType(TextField).at(0), 'user'); // Username
      await tester.enterText(find.byType(TextField).at(1), 'password'); // Password
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(); // Settle the navigation animation

    });
  });
}
