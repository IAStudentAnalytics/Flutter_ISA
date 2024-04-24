import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'resultat.dart';
import '../models/quiztestblanc.dart';
import '../services/testblancService.dart';

class TestBlanc extends StatefulWidget {
  const TestBlanc({Key? key}) : super(key: key);

  @override
  State<TestBlanc> createState() => _TestBlancState();
}

class _TestBlancState extends State<TestBlanc> {
  Future<List<QuizQuestion>?> quizQuestions = Future.value(null);
  int currentQuestionIndex = 0;
  List<int?> selectedAnswers = [];

  @override
  void initState() {
    super.initState();

    loadQuizQuestions();
  }

  Future<void> loadQuizQuestions() async {
    try {
      final List<QuizQuestion> questions =
          await TestBlancService.fetchQuizQuestions();
      setState(() {
        quizQuestions = Future.value(questions);
        selectedAnswers = List.filled(questions.length, null);
      });
    } catch (error) {
      print('Erreur lors du chargement des questions : $error');
    }
  }
  void _nextQuestion() {
    setState(() {
      currentQuestionIndex++;
    });
  }

  void _previousQuestion() {
    setState(() {
      if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
      }
    });
  }

  double calculateScore(List<QuizQuestion> questions) {
    int score = 0;
    for (int i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] != null &&
          questions[i].correctAnswer ==
              questions[i].answers[selectedAnswers[i]!]) {
        score++;
      }
    }
    return (score / questions.length) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 237, 46, 46),
                  Color(0x00f6f1fb),
                ],
                stops: [0, 1],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/pim11.png',
              width: 150,
            ),
          ),
          FutureBuilder<List<QuizQuestion>?>(
            future: quizQuestions,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur : ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return buildQuiz(snapshot.data!);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildQuiz(List<QuizQuestion> questions) {
    final currentQuestion = questions[currentQuestionIndex];

    return Container(
      margin: EdgeInsets.only(top: 100.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${currentQuestion.question.trim()}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ...List.generate(currentQuestion.answers.length, (index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color.fromARGB(201, 237, 235, 235),
                  border: Border.all(color: Color.fromARGB(201, 237, 235, 235)),
                ),
                child: RadioListTile<int?>(
                  title: Text(currentQuestion.answers[index]),
                  value: index,
                  groupValue: selectedAnswers[currentQuestionIndex],
                  onChanged: (int? value) {
                    setState(() {
                      selectedAnswers[currentQuestionIndex] = value;
                    });
                  },
                ),
              );
            }),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Afficher le bouton "Précédent" si possible, aligné à gauche
                if (currentQuestionIndex > 0)
                  ElevatedButton(
                    onPressed: _previousQuestion,
                    style: ElevatedButton.styleFrom(),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back, color: Colors.black),
                        SizedBox(width: 4),
                        Text('Précédent'),
                      ],
                    ),
                  ),

                // Espace pour séparer les boutons
                Spacer(),

                // Afficher le bouton "Suivant" ou "Terminer" aligné à droite
                if (currentQuestionIndex < questions.length - 1)
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: Row(
                      children: [
                        Text('Suivant'),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, color: Colors.black),
                      ],
                    ),
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      double score = calculateScore(questions);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Resultat(
                            score: score,
                            questions: questions,
                            selectedAnswers: selectedAnswers,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(),
                    child: Row(
                      children: [
                        Text('Terminer'),
                        SizedBox(width: 4),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}