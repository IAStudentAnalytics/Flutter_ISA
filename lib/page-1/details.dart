import 'package:flutter/material.dart';
import '../models/quiztestblanc.dart';

class QuestionDetailsPage extends StatelessWidget {
  final List<QuizQuestion> questions;
  final List<int?> selectedAnswers;

  const QuestionDetailsPage({
    required this.questions,
    required this.selectedAnswers,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Ajout d'une décoration à l'arrière-plan
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
        

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                 child: Row(
          children: [
              Icon(Icons.arrow_back, color: Colors.black),
            SizedBox(width: 4),
            Text('Retour'),
       
          ],
        ),
              ),
              for (int i = 0; i < questions.length; i++)
                buildQuestionCard(questions[i], selectedAnswers[i]),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuestionCard(QuizQuestion question, int? selectedAnswerIndex) {
    final selectedAnswer = selectedAnswerIndex != null
        ? question.answers[selectedAnswerIndex]
        : null;
    final correctAnswer = question.correctAnswer;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        child: Container(
          constraints: BoxConstraints(
            minWidth: double
                .infinity, // Permet aux cartes de prendre toute la largeur disponible
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question: ${question.question}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Chapitre: ${question.chapter}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  'Votre réponse: ${selectedAnswer ?? "Non répondu"}',
                  style: TextStyle(
                    color: selectedAnswer == correctAnswer
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                Text(
                  'Réponse correcte: $correctAnswer',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}