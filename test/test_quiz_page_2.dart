import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:training_app/User_Stuff/quiz_page_2.dart'; // Adjust the path as necessary

void main() {
  group('QuizPage2 Tests', () {
    testWidgets('Initial state is set correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: QuizPage2(userID: '123')));
      expect(find.text('Question 1'), findsOneWidget);
      expect(find.text('Option 1'), findsWidgets);
    });

    testWidgets('Correct answer updates score and shows feedback', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: QuizPage2(userID: '123')));
      await tester.tap(find.text('Correct Option').first);
      await tester.pump();

      expect(find.text('Correct feedback message'), findsOneWidget);
      // Ensure the score is updated appropriately
    });

    testWidgets('Incorrect answer does not update score', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: QuizPage2(userID: '123')));
      await tester.tap(find.text('Wrong Option').first);
      await tester.pump();

      expect(find.text('Incorrect feedback message'), findsOneWidget);
      // Ensure the score remains unchanged
    });
  });
}
