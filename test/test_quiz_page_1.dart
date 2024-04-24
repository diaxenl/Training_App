import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/User_Stuff/quiz_page_1.dart'; // Adjust the path as necessary

void main() {
  group('QuizPage1 Tests', () {
    testWidgets('Initial state is correct', (WidgetTester tester) async {
      // Mock data or dependencies if necessary
      await tester.pumpWidget(const MaterialApp(home: QuizPage1(userID: '123')));

      // Verify initial state
      expect(find.text('Question 1'), findsOneWidget);
      expect(find.text('Option 1'), findsWidgets);
      expect(find.byType(Radio), findsWidgets);
    });

    testWidgets('Answering correctly updates score and shows correct feedback', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: QuizPage1(userID: '123')));

      // Simulate answering a question correctly
      await tester.tap(find.text('Correct Option').first);
      await tester.pump();

      // Verify score update and feedback
      expect(find.text('Correct feedback message'), findsOneWidget);
    });

  });
}
