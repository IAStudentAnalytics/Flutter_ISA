import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pim/models/question.dart';
import 'dart:convert';
import 'package:pim/page-1/performance.dart';
import 'package:pim/page-1/resultatQuiz.dart';

import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'qa.dart';
import 'quiz.dart';

class TestPage extends StatefulWidget {
  final List<Question> questions;
  final String testId; // Store the test ID

  const TestPage({Key? key, required this.questions, required this.testId})
      : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int currentIndex = 0;
  List<String> answers = [];
  String? studentId;
/*
  @override
  void initState() {
    super.initState();
    answers = List<String>.filled(widget.questions.length, '', growable: false);
  }*/
  @override
  void initState() {
    super.initState();
    _initUserData();
    answers = List<String>.filled(widget.questions.length, '', growable: false);
  }

  Future<void> _initUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userDataString = prefs.getString('userData');
    print('xxxxxuserDataString: $userDataString'); // Débogage
    if (userDataString != null) {
      final Map<String, dynamic> userData = json.decode(userDataString);
      final Map<String, dynamic> user = userData['user'];
      setState(() {
        studentId = user['_id'];
      });
    } else {
      print('User data is null');
    }
  }

  void goToNextQuestion(String answer) {
    setState(() {
      answers[currentIndex] = answer;
    });

    if (currentIndex < widget.questions.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      submitAnswers();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) =>
            ResultQuiz(studentId: studentId!, testId: widget.testId),
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
    print(answers);
    print(widget.testId);
    final response = await http.post(
      Uri.parse('http://172.16.1.188:5000/note/tests/submit'),
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
