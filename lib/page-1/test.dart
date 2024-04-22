import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pim/models/question.dart';
import 'dart:convert';
import 'qa.dart';
import 'quiz.dart';


class TestPage extends StatefulWidget {
  final List<Question> questions;

  final String testId; // Ajouter cet attribut pour stocker l'ID du test

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
      // Fin du test : Gérer la fin du test ici.
    }
  }

  void submitAnswers() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.17:5000/note/tests/submit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'testId': widget.testId,
        'studentId': '65defb8a796124616d1ecdc0',
        'answers': answers,
      }),
    );

    if (response.statusCode == 200) {
      print('Réponses soumises avec succès');
      
    } else {
      print('Échec de la soumission des réponses');
    }
  }


  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[currentIndex];
    final isQuiz = currentQuestion.type == 'Quiz';
    final answer = '';
    return Scaffold(
      appBar: AppBar(title: Text('Test')),
      body: isQuiz 
       ? Quiz(question: currentQuestion, onNext: goToNextQuestion)
      : QAPage(question: currentQuestion, onNext: goToNextQuestion),
    );
  }
}