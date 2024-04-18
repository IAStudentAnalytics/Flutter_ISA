
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pim/page-1/quiztestblanc.dart';
import 'quiz.dart';

class Resultat extends StatelessWidget {
  final double score;
  final List<QuizQuestion> questions;
  final List<int?> selectedAnswers;

  Resultat({
    required this.score,
    required this.questions,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    // Calculer le nombre total de questions par chapitre et les réponses correctes par chapitre
    Map<String, int> chapterCounts = HashMap<String, int>();
    Map<String, int> correctAnswersCount = HashMap<String, int>();

    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];
      final selectedAnswerIndex = selectedAnswers[i];
      final selectedAnswer = selectedAnswerIndex != null
          ? question.answers[selectedAnswerIndex]
          : null;

      // Calculer le nombre total de questions par chapitre
      if (chapterCounts.containsKey(question.chapter)) {
        chapterCounts[question.chapter] = chapterCounts[question.chapter]! + 1;
      } else {
        chapterCounts[question.chapter] = 1;
      }

      // Calculer le nombre de réponses correctes par chapitre
      if (selectedAnswer == question.correctAnswer) {
        if (correctAnswersCount.containsKey(question.chapter)) {
          correctAnswersCount[question.chapter] =
              correctAnswersCount[question.chapter]! + 1;
        } else {
          correctAnswersCount[question.chapter] = 1;
        }
      }
    }

    // Calculer les pourcentages de chaque chapitre et de réponses correctes par chapitre
    Map<String, double> chapterPercentages = HashMap<String, double>();
    Map<String, double> correctAnswerPercentages = HashMap<String, double>();

    chapterCounts.forEach((chapter, count) {
      chapterPercentages[chapter] = (count / questions.length) * 100;
      final correctCount = correctAnswersCount[chapter] ?? 0;
      correctAnswerPercentages[chapter] = (correctCount / count) * 100;
    });

    // Convertir les données pour le graphique à barres
    List<BarChartGroupData> barChartData =
        chapterPercentages.entries.map((entry) {
      return BarChartGroupData(
        x: chapterPercentages.keys.toList().indexOf(entry.key),
        barRods: [
          BarChartRodData(
            y: entry.value,
            colors: [Colors.blue],
          ),
        ],
      );
    }).toList();

    return Scaffold(
      body: Container(
        // Ajoutez une décoration pour le dégradé de couleur linéaire
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
          // Utilisez SingleChildScrollView pour rendre la page scrollable
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Votre score est de : $score%',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Pourcentage de chaque chapitre :',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              //SizedBox(height: 8),
              // Graphique à barres
              Container(
                height: 200, // Définir une hauteur pour le graphique
                child: BarChart(
                  BarChartData(
                    barGroups: barChartData,
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(
                          showTitles:
                              false), // Ne pas montrer les titres sur l'axe gauche
                      bottomTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        getTitles: (value) {
                          final index = value.toInt();
                          final chapterName =
                              chapterPercentages.keys.toList()[index];
                          return chapterName;
                        },
                      ),
                      topTitles: SideTitles(
                          showTitles:
                              false), // Ne pas montrer les titres sur l'axe supérieur
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 16),
              // Affichage des pourcentages de réponses correctes par chapitre
              Text(
                'Pourcentages de réponses correctes par chapitre :',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              //SizedBox(height: 8),
              for (final chapter in correctAnswerPercentages.keys)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Chapitre: $chapter\n'
                    'Pourcentage de réponses correctes: ${correctAnswerPercentages[chapter]!.toStringAsFixed(2)}%',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              Divider(),
              Text(
                'Détails de chaque question :',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              //SizedBox(height: 8),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' ${question.question}',
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
    );
  }
}