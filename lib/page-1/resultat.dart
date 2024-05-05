import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pim/models/CoursR.dart';
import 'package:pim/services/coursRecService.dart';
import '../models/quiztestblanc.dart';
import 'details.dart';
import 'package:url_launcher/url_launcher.dart';

class Resultat extends StatefulWidget {
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
  _ResultatState createState() => _ResultatState();
}

class _ResultatState extends State<Resultat> {
  late Future<List<CoursR>> coursList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    coursList = CoursService.fetchCours();
    coursList.then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  void openPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      print('Error: Unable to open URL $pdfUrl');
    }
  }

  Map<String, List<CoursR>> groupCoursByNomCoursR(List<CoursR> coursList) {
    Map<String, List<CoursR>> groupedCours = {};

    for (var cours in coursList) {
      if (!groupedCours.containsKey(cours.nomCoursR)) {
        groupedCours[cours.nomCoursR] = [];
      }
      groupedCours[cours.nomCoursR]!.add(cours);
    }

    return groupedCours;
  }

  @override
  Widget build(BuildContext context) {
    // Calculer le nombre total de questions par chapitre et les réponses correctes par chapitre
    Map<String, int> chapterCounts = HashMap<String, int>();
    Map<String, int> correctAnswersCount = HashMap<String, int>();

    for (int i = 0; i < widget.questions.length; i++) {
      final question = widget.questions[i];
      final selectedAnswerIndex = widget.selectedAnswers[i];
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

    // Calculer les pourcentages de réponses correctes par chapitre
    Map<String, double> correctAnswerPercentages = HashMap<String, double>();
    chapterCounts.forEach((chapter, count) {
      final correctCount = correctAnswersCount[chapter] ?? 0;
      correctAnswerPercentages[chapter] = (correctCount / count) * 100;
    });
    Map<String, double> chapterPercentages = HashMap<String, double>();
    chapterCounts.forEach((chapter, count) {
      chapterPercentages[chapter] = (count / widget.questions.length) * 100;
    });
    List<BarChartGroupData> barChartData =
        chapterPercentages.entries.map((entry) {
      return BarChartGroupData(
        x: chapterPercentages.keys.toList().indexOf(entry.key),
        barRods: [
          BarChartRodData(
            y: entry.value.toDouble(),
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
                sectionsSpace: 2,
              ),
            ),
          ),
          SizedBox(height: 8),
        ],
      );
    }).toList();

    // return Scaffold(
    //   body: Container(
    //     decoration: BoxDecoration(
    //       gradient: LinearGradient(
    //         begin: Alignment.topCenter,
    //         end: Alignment.bottomCenter,
    //         colors: [
    //           Color.fromARGB(255, 237, 46, 46),
    //           Color(0xFFF6F1FB),
    //         ],
    //         stops: [0, 1],
    //       ),
    //     ),
    //     child: isLoading
    //         ? Center(child: CircularProgressIndicator())
    //         : SingleChildScrollView(
    //             padding: const EdgeInsets.all(16.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Align(
    //                   alignment: Alignment
    //                       .topLeft, // Déplace l'image vers le haut et la gauche
    //                   child: Padding(
    //                     padding: EdgeInsets.only(
    //                         top:
    //                             22.0), // Ajoute un padding supplémentaire vers le haut
    //                     child: Image.asset(
    //                       'assets/pim11.png',
    //                       width: 150,
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(height: 16),
    //                 Text(
    //                   'Your score is : ${widget.score}%',
    //                   style: TextStyle(
    //                     fontSize: 20.0,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 TextButton(
    //                   onPressed: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => QuestionDetailsPage(
    //                           questions: widget.questions,
    //                           selectedAnswers: widget.selectedAnswers,
    //                         ),
    //                       ),
    //                     );
    //                   },
    //                   child: Text(
    //                     'Click here for more details',
    //                     style: TextStyle(
    //                       color: Colors.blue,
    //                       decoration: TextDecoration.underline,
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(height: 16),
    //                 Text(
    //                   'Percentage of each chapter :',
    //                   style: TextStyle(
    //                     fontSize: 18,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 Container(
    //                   height: 200,
    //                   child: BarChart(
    //                     BarChartData(
    //                       barGroups: barChartData,
    //                       borderData: FlBorderData(show: false),
    //                       titlesData: FlTitlesData(
    //                         leftTitles: SideTitles(
    //                           showTitles: false,
    //                         ),
    //                         bottomTitles: SideTitles(
    //                           showTitles: true,
    //                           reservedSize: 32,
    //                           getTitles: (value) {
    //                             final index = value.toInt();
    //                             final chapterName =
    //                                 chapterCounts.keys.toList()[index];
    //                             return chapterName;
    //                           },
    //                           getTextStyles: (context, value) =>
    //                               MediaQuery.of(context).size.width < 600
    //                                   ? TextStyle(
    //                                       fontSize: MediaQuery.of(context)
    //                                               .size
    //                                               .width /
    //                                           65)
    //                                   : TextStyle(fontSize: 14),
    //                         ),
    //                         topTitles: SideTitles(
    //                           showTitles: false,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(height: 16),
    //                 Text(
    //                   'Percentages of correct answers per chapter :',
    //                   style: TextStyle(
    //                     fontSize: 18,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                   SizedBox(height: 16),

    //                    Center(
    //             child: SingleChildScrollView(
    //               scrollDirection: Axis.horizontal,
    //               padding: EdgeInsets.all(20.0),
    //               child: Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   for (final chart in pieCharts) ...[
    //                     chart,
    //                     SizedBox(
    //                         width:
    //                             30), // Ajoutez un espace entre chaque graphique
    //                   ],
    //                 ],
    //               ),
    //             ),
    //           ),
    //                  SizedBox(height: 16),
    //                     Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Container(
    //                       width: 12,
    //                       height: 15,
    //                       color: Colors.blue,
    //                     ),
    //                     SizedBox(width: 8),
    //                     Text(
    //                       'Correct answers',
    //                       style: TextStyle(fontSize: 14),
    //                     ),
    //                     SizedBox(width: 16),
    //                     Container(
    //                       width: 12,
    //                       height: 15,
    //                       color: Colors.grey,
    //                     ),
    //                     SizedBox(width: 8),
    //                     Text(
    //                       'Incorrect answers',
    //                       style: TextStyle(fontSize: 14),
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(height: 16),
    //                 Text(
    //                   'You can consult these courses to improve your weaknesses:',
    //                   style: TextStyle(
    //                     fontSize: 18,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 SizedBox(height: 16),

    //                 FutureBuilder<List<CoursR>>(
    //                   future: coursList,
    //                   builder: (context, snapshot) {
    //                     if (snapshot.connectionState ==
    //                         ConnectionState.waiting) {
    //                       return Center(child: CircularProgressIndicator());
    //                     } else if (snapshot.hasError) {
    //                       return Center(
    //                           child: Text('Erreur : ${snapshot.error}'));
    //                     } else if (snapshot.hasData) {
    //                       Map<String, List<CoursR>> groupedCours =
    //                           groupCoursByNomCoursR(snapshot.data!);

    //                       // Filtrer les chapitres avec un pourcentage de réponses correctes inférieur à 100%
    //                       Map<String, double> filteredCorrectAnswerPercentages =
    //                           {};

    //                       correctAnswerPercentages.forEach((key, value) {
    //                         if (value < 100) {
    //                           filteredCorrectAnswerPercentages[key] = value;
    //                         }
    //                       });

    //                       List<String> filteredChapters =
    //                           filteredCorrectAnswerPercentages.keys.toList();

    //                       return Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           for (var entry in groupedCours.entries)
    //                             if (filteredChapters.contains(entry.key)) ...[
    //                               Text(
    //                                 entry.key,
    //                                 style: TextStyle(
    //                                   fontSize: 16,
    //                                   fontWeight: FontWeight.bold,
    //                                 ),
    //                               ),
    //                               SizedBox(height: 8),
    //                               for (var cours in entry.value)
    //                                 Padding(
    //                                   padding: const EdgeInsets.symmetric(
    //                                       vertical: 4.0),
    //                                   child: TextButton(
    //                                     onPressed: () {
    //                                       openPdf(cours.pdff);
    //                                     },
    //                                     child: Text(
    //                                       cours.description,
    //                                       style: TextStyle(
    //                                         fontSize: 14,
    //                                         fontWeight: FontWeight.normal,
    //                                         color: Colors.blue,
    //                                         decoration:
    //                                             TextDecoration.underline,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ),

    //                             ],
    //                         ],
    //                       );
    //                     } else {
    //                       return Center(child: CircularProgressIndicator());
    //                     }
    //                   },
    //                 ),
    //                 SizedBox(height: 16),
    //               ],
    //             ),
    //           ),
    //   ),
    // );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 237, 46, 46),
              Color(0xFFF6F1FB),
            ],
            stops: [0, 1],
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 22.0),
                        child: Image.asset(
                          'assets/pim11.png',
                          width: 150,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Your score : ${widget.score}%',
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
                              questions: widget.questions,
                              selectedAnswers: widget.selectedAnswers,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Click here for more details',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Percentage of each chapter :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          barGroups: barChartData,
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: SideTitles(
                              showTitles: false,
                            ),
                            bottomTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 32,
                              getTitles: (value) {
                                final index = value.toInt();
                                final chapterName =
                                    chapterCounts.keys.toList()[index];
                                return chapterName;
                              },
                              getTextStyles: (context, value) =>
                                  MediaQuery.of(context).size.width < 600
                                      ? TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              65)
                                      : TextStyle(fontSize: 14),
                            ),
                            topTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Percentages of correct answers per chapter :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (final chart in pieCharts) ...[
                              chart,
                              SizedBox(width: 30),
                            ],
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 12,
                          height: 15,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Correct answers',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 16),
                        Container(
                          width: 12,
                          height: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Incorrect answers',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'You can consult these courses to improve your weaknesses:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            FutureBuilder<List<CoursR>>(
                              future: coursList,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child:
                                          Text('Erreur : ${snapshot.error}'));
                                } else if (snapshot.hasData) {
                                  Map<String, List<CoursR>> groupedCours =
                                      groupCoursByNomCoursR(snapshot.data!);

                                  // Filtrer les chapitres avec un pourcentage de réponses correctes inférieur à 100%
                                  Map<String, double>
                                      filteredCorrectAnswerPercentages = {};

                                  correctAnswerPercentages
                                      .forEach((key, value) {
                                    if (value < 100) {
                                      filteredCorrectAnswerPercentages[key] =
                                          value;
                                    }
                                  });

                                  List<String> filteredChapters =
                                      filteredCorrectAnswerPercentages.keys
                                          .toList();

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (var entry in groupedCours.entries)
                                        if (filteredChapters
                                            .contains(entry.key)) ...[
                                          Text(
                                            entry.key,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          for (var cours in entry.value)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: TextButton(
                                                onPressed: () {
                                                  openPdf(cours.pdff);
                                                },
                                                child: Text(
                                                  cours.description,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.blue,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                    ],
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
