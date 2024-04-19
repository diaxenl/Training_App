import 'package:flutter/material.dart';
import 'package:training_app/User_Stuff/user_home.dart';
import 'DatabaseHelper.dart';

// StatefulWidget for the first quiz page
class QuizPage2 extends StatefulWidget {
  final String userID;

  const QuizPage2({super.key, required this.userID});

  @override
  State<QuizPage2> createState() => _QuizPage2State();
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

// State class for the QuizPage2
class _QuizPage2State extends State<QuizPage2> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  String? _feedback;
  bool _answered = false;
  final List<Question> _questions = [
    Question(
      questionText: 'Which country is known as the Land of the Rising Sun?',
      options: ['China', 'Japan', 'South Korea', 'Thailand'],
      correctIndex: 1,
      correctFeedback: 'Correct! Japan is known as the Land of the Rising Sun.',
      incorrectFeedback: 'Incorrect. The correct answer is Japan.',
    ),
    Question(
      questionText: 'What is the chemical symbol for water?',
      options: ['CO2', 'O2', 'H2O', 'N2'],
      correctIndex: 2,
      correctFeedback: 'Correct! The chemical symbol for water is H2O.',
      incorrectFeedback: 'Incorrect. The correct answer is H2O.',
    ),
    Question(
      questionText: 'Who wrote "Romeo and Juliet"?',
      options: ['Charles Dickens', 'William Shakespeare', 'Jane Austen', 'Mark Twain'],
      correctIndex: 1,
      correctFeedback: 'Correct! "Romeo and Juliet" was written by William Shakespeare.',
      incorrectFeedback: 'Incorrect. The correct answer is William Shakespeare.',
    ),
    Question(
      questionText: 'Which element has the atomic number 1?',
      options: ['Oxygen', 'Helium', 'Hydrogen', 'Nitrogen'],
      correctIndex: 2,
      correctFeedback: 'Correct! Hydrogen has the atomic number 1.',
      incorrectFeedback: 'Incorrect. The correct answer is Hydrogen.',
    ),
    Question(
      questionText: 'Which city hosted the 2012 Summer Olympics?',
      options: ['Beijing', 'London', 'Rio de Janeiro', 'Tokyo'],
      correctIndex: 1,
      correctFeedback: 'Correct! The 2012 Summer Olympics were held in London.',
      incorrectFeedback: 'Incorrect. The correct answer is London.',
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
      appBar: AppBar(title: const Text('Quiz 2 Start'), backgroundColor: Colors.orange),
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
    await DatabaseHelper.instance.updateUserQuiz2Completion(int.parse(userId), true);
  }
}
