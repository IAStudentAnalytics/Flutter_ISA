//code stat f milieu
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/quiztestblanc.dart';
import 'details.dart';

class Resultat extends StatelessWidget {
  final double score;
  final List<QuizQuestion> questions;
  final List<int?> selectedAnswers;

  const Resultat({
    required this.score,
    required this.questions,
    required this.selectedAnswers,
    Key? key,
  }) : super(key: key);

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
          correctAnswersCount[question.chapter]! + 1;
        } else {
          correctAnswersCount[question.chapter] = 1;
        }
      }
    }

    // Calculer les pourcentages de réponses correctes par chapitre
    Map<String, double> correctAnswerPercentages = HashMap<String, double>();
    chapterCounts.forEach((chapter, count) {
      final correctCount = correctAnswersCount[chapter] ?? 0;
      correctAnswerPercentages[chapter] = (correctCount / count) * 100;
    });
    Map<String, double> chapterPercentages = HashMap<String, double>();
    chapterCounts.forEach((chapter, count) {
      chapterPercentages[chapter] = (count / questions.length) * 100;
    });
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
    List<Widget> pieCharts = correctAnswerPercentages.entries.map((entry) {
      final chapter = entry.key;
      final percentage = entry.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            chapter,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 80,
            height: 80,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: percentage,
                    color: Colors.blue,
                    title: '${percentage.toStringAsFixed(2)}%',
                    radius: 30,
                    titleStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  PieChartSectionData(
                    value: 100 - percentage,
                    color: Colors.grey,
                    title: '${(100 - percentage).toStringAsFixed(2)}%',
                    radius: 25,
                    titleStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
                centerSpaceRadius: 20,
                sectionsSpace: 2, // Espace entre les sections
              ),
            ),
          ),
          SizedBox(height: 8),
        ],
      );
    }).toList();

    return Scaffold(
      body: Container(
        // Décoration pour le dégradé de couleur linéaire
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
              Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  'assets/pim11.png',
                  width: 150,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Votre score est de : $score%',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionDetailsPage(
                        questions: questions,
                        selectedAnswers: selectedAnswers,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Cliquez ici pour plus de détails',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Pourcentage de chaque chapitre :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Graphique à barres
              Container(
                height: 200,
                child: BarChart(
                  BarChartData(
                    barGroups: barChartData,
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(
                        showTitles: false,
                      ), // Pas de titres sur l'axe gauche
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
                        showTitles: false,
                      ), // Pas de titres sur l'axe supérieur
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Pourcentages de réponses correctes par chapitre :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Afficher tous les graphiques circulaires sur une seule ligne
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (final chart in pieCharts) ...[
                        chart,
                        SizedBox(
                            width:
                                30), // Ajoutez un espace entre chaque graphique
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Afficher la légende des couleurs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Légende couleur correcte
                  Container(
                    width: 15,
                    height: 15,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Réponses correctes',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(width: 16),
                  // Légende couleur incorrecte
                  Container(
                    width: 15,
                    height: 15,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Réponses incorrectes',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}