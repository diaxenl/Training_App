import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:training_app/User_Stuff/user_home.dart'; // Adjust the path as necessary

void main() {
  group('UserHome Page Tests', () {
    testWidgets('Initial State and UI Elements', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: UserHome()));

      // Check for initial state correctness
      expect(find.byType(TextEditingController), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
    });

    testWidgets('Search Functionality', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: UserHome()));
      await tester.enterText(find.byType(TextField), 'query');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
    });

    testWidgets('Navigation to Training', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: UserHome()));
      await tester.tap(find.text('Training 1'));
      await tester.pumpAndSettle(); // Wait for navigation to complete
    });
  });
}
