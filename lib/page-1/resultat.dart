
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
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
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
          correctAnswersCount[question.chapter] = correctAnswersCount[question.chapter]! + 1;
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

    List<BarChartGroupData> barChartData =
        chapterCounts.entries.map((entry) {
      return BarChartGroupData(
        x: chapterCounts.keys.toList().indexOf(entry.key),
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
                    color: const Color.fromARGB(255, 33, 243, 65),
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
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'assets/pim11.png',
                        width: 150,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Votre score est de : ${widget.score}%',
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
                      'Pourcentages de réponses correctes par chapitre :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
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
                          width: 15,
                          height: 15,
                           color: const Color.fromARGB(255, 33, 243, 65),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Réponses correctes',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 16),
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
                    SizedBox(height: 20),
                    Text(
                      'Pour améliorer votre niveau , vous pouvez consulter ces cours :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Tableau pour afficher les cours
                    /*temchi jawha behi 
                    FutureBuilder<List<CoursR>>(
  future: coursList,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Erreur : ${snapshot.error}'));
    } else if (snapshot.hasData) {
      Map<String, List<CoursR>> groupedCours = groupCoursByNomCoursR(snapshot.data!);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var entry in groupedCours.entries)
            ...[
              Text(
                entry.key,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              for (var cours in entry.value)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextButton(
                    onPressed: () {
                      openPdf(cours.pdff);
                    },
                    child: Text(
                      cours.description,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 16),
            ],
        ],
      );*/
      FutureBuilder<List<CoursR>>(
  future: coursList,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Erreur : ${snapshot.error}'));
    } else if (snapshot.hasData) {
      Map<String, List<CoursR>> groupedCours = groupCoursByNomCoursR(snapshot.data!);

      // Filtrer les chapitres avec un pourcentage de réponses correctes inférieur à 100%
      Map<String, double> filteredCorrectAnswerPercentages = {};

      correctAnswerPercentages.forEach((key, value) {
        if (value < 100) {
          filteredCorrectAnswerPercentages[key] = value;
        }
      });

      List<String> filteredChapters = filteredCorrectAnswerPercentages.keys.toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var entry in groupedCours.entries)
            if (filteredChapters.contains(entry.key)) ...[
              Text(
                entry.key,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              for (var cours in entry.value)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextButton(
                    onPressed: () {
                      openPdf(cours.pdff);
                    },
                    child: Text(
                      cours.description,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 16),
            ],
        ],
      );

                    /*FutureBuilder<List<CoursR>>(
                      future: coursList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erreur : ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          return DataTable(
                            columns: [
                              DataColumn(label: Text('Nom du Cours')),
                              DataColumn(label: Text('Description')),
                            ],
                            rows: snapshot.data!.map((cours) {
                              return DataRow(cells: [
                                DataCell(Text(cours.nomCoursR)),
                                DataCell(Text(cours.description)),
                              ]);
                            }).toList(),
                          );*/
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    
                  ],
                ),
              ),
      ),
    );
  }
}
/*
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pim/models/CoursR.dart';
import 'package:pim/models/quiztestblanc.dart';
import 'package:pim/services/coursRecService.dart';
import 'package:url_launcher/url_launcher.dart';
import 'details.dart';

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
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
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
          correctAnswersCount[question.chapter] = correctAnswersCount[question.chapter]! + 1;
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

    List<BarChartGroupData> barChartData =
        chapterCounts.entries.map((entry) {
      return BarChartGroupData(
        x: chapterCounts.keys.toList().indexOf(entry.key),
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
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'assets/pim11.png',
                        width: 150,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Votre score est de : ${widget.score}%',
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
                      'Pourcentages de réponses correctes par chapitre :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
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
                    Text(
                      'Liste des cours :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Tableau pour afficher les cours
                    FutureBuilder<List<CoursR>>(
                      future: coursList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erreur : ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          return DataTable(
                            columns: [
                              DataColumn(label: Text('Nom du Cours')),
                              DataColumn(label: Text('Description')),
                            ],
                            rows: snapshot.data!.map((cours) {
                              return DataRow(cells: [
                                DataCell(Text(cours.nomCoursR)),
                                DataCell(Text(cours.description)),
                              ]);
                            }).toList(),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
}*/
/*
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
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
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
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'assets/pim11.png',
                        width: 150,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Votre score est de : ${widget.score}%',
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
                        'Cliquez ici pour plus de détails',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Description par cours :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    FutureBuilder<List<CoursR>>(
                      future: coursList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erreur : ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          Map<String, List<CoursR>> groupedCours =
                              groupCoursByNomCoursR(snapshot.data!);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var entry in groupedCours.entries)
                                ...[
                                  Text(
                                    entry.key,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  for (var cours in entry.value)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      child: Text(cours.description),
                                    ),
                                  SizedBox(height: 16),
                                ],
                            ],
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Pourcentage de chaque chapitre :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Ici, vous pouvez ajouter le code pour le graphique de barres
                    SizedBox(height: 16),
                    Text(
                      'Pourcentages de réponses correctes par chapitre :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Ici, vous pouvez ajouter le code pour les graphiques de camembert
                    SizedBox(height: 16),
                    Text(
                      'Liste des cours :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Ici, vous pouvez ajouter le code pour la liste des cours
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
*/


/*
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
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
  }

  Map<String, List<CoursR>> groupCoursByChapterName(List<CoursR> coursList) {
    Map<String, List<CoursR>> groupedCours = {};

    for (var cours in coursList) {
      if (!groupedCours.containsKey(cours.nomCoursR)) {
        groupedCours[cours.nomCoursR] = [];
      }
      groupedCours[cours.nomCoursR]!.add(cours);
    }

    return groupedCours;
  }

  Map<String, int> calculateChapterCounts(List<QuizQuestion> questions) {
    Map<String, int> chapterCounts = {};

    for (var question in questions) {
      if (chapterCounts.containsKey(question.chapter)) {
        chapterCounts[question.chapter] = chapterCounts[question.chapter]! + 1;
      } else {
        chapterCounts[question.chapter] = 1;
      }
    }

    return chapterCounts;
  }

  Map<String, double> calculateCorrectAnswerPercentages(Map<String, int> chapterCounts) {
    Map<String, int> correctAnswersCount = {};

    for (int i = 0; i < widget.questions.length; i++) {
      final question = widget.questions[i];
      final selectedAnswerIndex = widget.selectedAnswers[i];
      final selectedAnswer = selectedAnswerIndex != null
          ? question.answers[selectedAnswerIndex]
          : null;

      if (selectedAnswer == question.correctAnswer) {
        if (correctAnswersCount.containsKey(question.chapter)) {
          correctAnswersCount[question.chapter] = correctAnswersCount[question.chapter]! + 1;
        } else {
          correctAnswersCount[question.chapter] = 1;
        }
      }
    }

    Map<String, double> correctAnswerPercentages = {};

    chapterCounts.forEach((chapter, count) {
      final correctCount = correctAnswersCount[chapter] ?? 0;
      correctAnswerPercentages[chapter] = (correctCount / count) * 100;
    });

    return correctAnswerPercentages;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> chapterCounts = calculateChapterCounts(widget.questions);
    Map<String, double> correctAnswerPercentages = calculateCorrectAnswerPercentages(chapterCounts);

    List<BarChartGroupData> barChartData =
        chapterCounts.entries.map((entry) {
      return BarChartGroupData(
        x: chapterCounts.keys.toList().indexOf(entry.key),
        barRods: [
          BarChartRodData(
            y: entry.value.toDouble(),
            colors: [Colors.blue],
          ),
        ],
      );
    }).toList();

    List<PieChartSectionData> pieChartData =
        correctAnswerPercentages.entries.map((entry) {
      final chapter = entry.key;
      final percentage = entry.value;

      return PieChartSectionData(
        value: percentage,
        color: Colors.blue,
        title: '${percentage.toStringAsFixed(2)}%',
        radius: 30,
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      );
    }).toList();

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
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'assets/pim11.png',
                        width: 150,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Votre score est de : ${widget.score}%',
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
                                final chapterName = chapterCounts.keys.toList()[index];
                                return chapterName;
                              },
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
                      'Pourcentages de réponses correctes par chapitre :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: pieChartData,
                          centerSpaceRadius: 20,
                          sectionsSpace: 2,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Liste des cours :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Liste des cours
                    FutureBuilder<List<CoursR>>(
                      future: coursList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erreur : ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          Map<String, List<CoursR>> groupedCours = groupCoursByChapterName(snapshot.data!);
                          return Column(
                            children: groupedCours.entries.map((entry) {
                              final chapterName = entry.key;
                              final coursList = entry.value;

                              return Card(
                                elevation: 4,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        chapterName,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onTap: () {
                                        // Ajoutez ici une action à effectuer lorsque vous cliquez sur le titre du chapitre
                                      },
                                    ),
                                    Divider(),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: coursList.length,
                                      itemBuilder: (context, index) {
                                        final cours = coursList[index];
                                        return ListTile(
                                          title: Text(cours.nomCoursR),
                                          subtitle: Text(cours.description),
                                          trailing: IconButton(
                                            icon: Icon(Icons.file_download),
                                            onPressed: () {
                                              //openPdf(cours.pdfUrl);
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
*/
/*
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
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
  }

  Map<String, List<CoursR>> groupCoursByChapterName(List<CoursR> coursList) {
    Map<String, List<CoursR>> groupedCours = {};

    for (var cours in coursList) {
      if (!groupedCours.containsKey(cours.nomCoursR)) {
        groupedCours[cours.nomCoursR] = [];
      }
      groupedCours[cours.nomCoursR]!.add(cours);
    }

    return groupedCours;
  }

  Map<String, int> calculateChapterCounts(List<QuizQuestion> questions) {
    Map<String, int> chapterCounts = {};

    for (var question in questions) {
      if (chapterCounts.containsKey(question.chapter)) {
        chapterCounts[question.chapter] = chapterCounts[question.chapter]! + 1;
      } else {
        chapterCounts[question.chapter] = 1;
      }
    }

    return chapterCounts;
  }

  Map<String, double> calculateCorrectAnswerPercentages(Map<String, int> chapterCounts) {
    Map<String, int> correctAnswersCount = {};

    for (int i = 0; i < widget.questions.length; i++) {
      final question = widget.questions[i];
      final selectedAnswerIndex = widget.selectedAnswers[i];
      final selectedAnswer = selectedAnswerIndex != null
          ? question.answers[selectedAnswerIndex]
          : null;

      if (selectedAnswer == question.correctAnswer) {
        if (correctAnswersCount.containsKey(question.chapter)) {
          correctAnswersCount[question.chapter] = correctAnswersCount[question.chapter]! + 1;
        } else {
          correctAnswersCount[question.chapter] = 1;
        }
      }
    }

    Map<String, double> correctAnswerPercentages = {};

    chapterCounts.forEach((chapter, count) {
      final correctCount = correctAnswersCount[chapter] ?? 0;
      correctAnswerPercentages[chapter] = (correctCount / count) * 100;
    });

    return correctAnswerPercentages;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> chapterCounts = calculateChapterCounts(widget.questions);
    Map<String, double> correctAnswerPercentages = calculateCorrectAnswerPercentages(chapterCounts);

    List<BarChartGroupData> barChartData =
        chapterCounts.entries.map((entry) {
      return BarChartGroupData(
        x: chapterCounts.keys.toList().indexOf(entry.key),
        barRods: [
          BarChartRodData(
            y: entry.value.toDouble(),
            colors: [Colors.blue],
          ),
        ],
      );
    }).toList();

    List<PieChartSectionData> pieChartData =
        correctAnswerPercentages.entries.map((entry) {
      final chapter = entry.key;
      final percentage = entry.value;

      return PieChartSectionData(
        value: percentage,
        color: Colors.blue,
        title: '${percentage.toStringAsFixed(2)}%',
        radius: 30,
        titleStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      );
    }).toList();

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
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'assets/pim11.png',
                        width: 150,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Votre score est de : ${widget.score}%',
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
                                final chapterName = chapterCounts.keys.toList()[index];
                                return chapterName;
                              },
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
                      'Pourcentages de réponses correctes par chapitre :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 300,  // Augmentation de la hauteur pour le graphique circulaire
                      child: PieChart(
                        PieChartData(
                          sections: pieChartData,
                          centerSpaceRadius: 20,
                          sectionsSpace: 2,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Liste des cours :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Liste des cours
                    FutureBuilder<List<CoursR>>(
                      future: coursList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erreur : ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          Map<String, List<CoursR>> groupedCours = groupCoursByChapterName(snapshot.data!);
                          return Column(
                            children: groupedCours.entries.map((entry) {
                              final chapterName = entry.key;
                              final coursList = entry.value;

                              return Card(
                                elevation: 4,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        chapterName,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onTap: () {
                                        // Ajoutez ici une action à effectuer lorsque vous cliquez sur le titre du chapitre
                                      },
                                    ),
                                    Divider(),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: coursList.length,
                                      itemBuilder: (context, index) {
                                        final cours = coursList[index];
                                        return ListTile(
                                          title: Text(cours.nomCoursR),
                                          subtitle: Text(cours.description),
                                          trailing: IconButton(
                                            icon: Icon(Icons.file_download),
                                            onPressed: () {
                                              //openPdf(cours.pdfUrl);
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
*/