import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pim/models/question.dart';
import 'dart:convert';
import 'package:pim/page-1/performance.dart';

import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'qa.dart';
import 'quiz.dart';

class TestPage extends StatefulWidget {
  final List<Question> questions;
  final String testId; // Store the test ID

  const TestPage({Key? key, required this.questions, required this.testId}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int currentIndex = 0;
  List<String> answers = [];

  @override
  void initState() {
    super.initState();
    answers = List<String>.filled(widget.questions.length, '', growable: false);
  }

  void goToNextQuestion(String answer) {
    if (currentIndex < widget.questions.length - 1) {
      setState(() {
        answers[currentIndex] = answer;
        currentIndex++;
      });
    } else {
      submitAnswers();
      Navigator.of(context).push(MaterialPageRoute(
                       builder: (_) =>
                          Performance(studentId: '65defb8f796124616d1ecdc2',),
                     ));
    }
  }

  Future<String> getStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    if (userData != null) {
      final data = jsonDecode(userData);
      return data['_id'] ?? 'default_student_id'; // Use default ID if not found
    }
    return 'default_student_id'; // Fallback ID if no userData is found
  }

  void submitAnswers() async {
    String studentId = await getStudentId(); // Fetch the dynamic student ID

    final response = await http.post(
      Uri.parse('http://192.168.1.54:5000/note/tests/submit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'testId': widget.testId,
        'studentId': studentId, // Use the dynamically fetched student ID
        'answers': answers,
      }),
    );

    if (response.statusCode == 200) {
      print('Réponses soumises avec succès');
      // Maybe navigate to a different screen or show a dialog
    } else {
      print('Échec de la soumission des réponses');
      // Handle errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[currentIndex];
    final isQuiz = currentQuestion.type == 'Quiz';

    return Scaffold(
      appBar: AppBar(title: Text('Test')),
      body: isQuiz 
        ? Quiz(question: currentQuestion, onNext: goToNextQuestion)
        : QAPage(question: currentQuestion, onNext: goToNextQuestion),
    );
  }
}
