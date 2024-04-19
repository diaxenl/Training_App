import 'package:flutter/material.dart';
import 'package:training_app/User_Stuff/user_home.dart';
import 'DatabaseHelper.dart';

// StatefulWidget for the first quiz page
class QuizPage1 extends StatefulWidget {
  final String userID;

  const QuizPage1({super.key, required this.userID});

  @override
  State<QuizPage1> createState() => _QuizPage1State();
}

// Model class to define a question
class Question {
  final String questionText;
  final List<String> options;
  final int correctIndex;
  final String correctFeedback;
  final String incorrectFeedback;

  Question({
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.correctFeedback,
    required this.incorrectFeedback,
  });
}

// State class for the QuizPage1
class _QuizPage1State extends State<QuizPage1> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  String? _feedback;
  bool _answered = false;
  final List<Question> _questions = [
    // List of questions used in the quiz
    Question(
      questionText: 'What is the capital of France?',
      options: ['New York', 'London', 'Paris', 'Berlin'],
      correctIndex: 2,
      correctFeedback: 'Correct! Paris is the capital of France.',
      incorrectFeedback: 'Incorrect. The correct answer is Paris.',
    ),
    Question(
      questionText: 'What is 2 + 2?',
      options: ['3', '4', '5', '6'],
      correctIndex: 1,
      correctFeedback: 'Correct! The answer is 4.',
      incorrectFeedback: 'Incorrect. The correct answer is 4.',
    ),
    Question(
      questionText: 'Which planet is known as the Red Planet?',
      options: ['Earth', 'Venus', 'Mars', 'Jupiter'],
      correctIndex: 2,
      correctFeedback: 'Correct! Mars is the Red Planet.',
      incorrectFeedback: 'Incorrect. The correct answer is Mars.',
    ),
    Question(
      questionText: 'What is the largest ocean on Earth?',
      options: ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
      correctIndex: 3,
      correctFeedback: 'Correct! The Pacific is the largest ocean.',
      incorrectFeedback: 'Incorrect. The correct answer is Pacific.',
    ),
    Question(
      questionText: 'What year did the Titanic sink?',
      options: ['1912', '1913', '1914', '1915'],
      correctIndex: 0,
      correctFeedback: 'Correct! The Titanic sank in 1912.',
      incorrectFeedback: 'Incorrect. The correct answer is 1912.',
    ),
  ];

  // Handles the user's answer and updates the state
  void _answerQuestion(int selectedOption) {
    if (_answered) return; // Prevents re-answering the question
    setState(() {
      _answered = true;
      _feedback = selectedOption == _questions[_currentQuestionIndex].correctIndex
          ? _questions[_currentQuestionIndex].correctFeedback
          : _questions[_currentQuestionIndex].incorrectFeedback;
      if (_feedback == _questions[_currentQuestionIndex].correctFeedback) _score++;
    });
  }

  // Navigates to the next question or results page
  void _nextQuestion() {
    if (_currentQuestionIndex + 1 == _questions.length) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResultsPage(score: _score, total: _questions.length, userID: widget.userID)));
    } else {
      setState(() {
        _currentQuestionIndex++;
        _answered = false;
        _feedback = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz 1 Start'), backgroundColor: Colors.orange),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(16.0), child: Text(question.questionText, style: const TextStyle(fontSize: 24))),
            ...question.options.map((option) => ElevatedButton(
              style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.orange, minimumSize: const Size(150, 50)),
              onPressed: () => _answerQuestion(question.options.indexOf(option)),
              child: Text(option),
            )),
            if (_feedback != null) Padding(padding: const EdgeInsets.all(8.0), child: Text(_feedback!, style: const TextStyle(fontSize: 18, color: Colors.red))),
            ElevatedButton(onPressed: _answered ? _nextQuestion : null, child: const Text('Next Question')),
          ],
        ),
      ),
    );
  }
}

// StatelessWidget for displaying quiz results
class ResultsPage extends StatelessWidget {
  final int score;
  final int total;
  final String userID;

  const ResultsPage({super.key, required this.score, required this.total, required this.userID});

  @override
  Widget build(BuildContext context) {
    if (score == total) {
      _updateQuizCompletion(userID); // Updates user's completion status
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Results'), backgroundColor: Colors.orange),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You scored $score out of $total', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UserHome())),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }

  // Updates the database with the quiz completion status
  void _updateQuizCompletion(String userId) async {
    await DatabaseHelper.instance.updateUserQuiz1Completion(int.parse(userId), true);
  }
}
