
import 'package:flutter/material.dart';
import 'package:pim/models/CoursR.dart';
import 'package:pim/services/coursRecService.dart';
import 'package:url_launcher/url_launcher.dart';

class Recomandation extends StatefulWidget {
  
  @override
  _RecomandationState createState() => _RecomandationState();
  
}

class _RecomandationState extends State<Recomandation> {
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
            : FutureBuilder<List<CoursR>>(
                future: coursList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erreur : ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final coursMap = groupCoursByNomCoursR(snapshot.data!);
                    return ListView.builder(
                      itemCount: coursMap.length,
                      itemBuilder: (context, index) {
                        final key = coursMap.keys.elementAt(index);
                        final list = coursMap[key]!;
                        return buildGroupedCard(key, list);
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
      ),
    );
  }

  Widget buildGroupedCard(String key, List<CoursR> coursList) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(8.0),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          key,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        children: coursList.map((cours) => buildCard(cours)).toList(),
      ),
    );
  }

  Widget buildCard(CoursR cours) {
    return ListTile(
      title: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: () {
            openPdf(cours.pdff);
          },
          child: Text(
            cours.description,
            style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
