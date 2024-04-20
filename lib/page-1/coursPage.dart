// views/cours_page.dart
import 'package:flutter/material.dart';
import 'package:pim/models/CoursR.dart';
import 'package:pim/services/coursRecService.dart';
import 'package:url_launcher/url_launcher.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  late Future<List<CoursR>> coursList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    coursList = CoursRecService.fetchCours();
    coursList.then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }
/*
  void deleteCours(String id) async {
    try {
      await CoursRecService.deleteCours(id);
      setState(() {
        coursList = CoursRecService.fetchCours();
      });
    } catch (error) {
      print('Erreur lors de la suppression du cours: $error');
    }
  }*/

  void openPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
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
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final cours = snapshot.data![index];
                        return buildCard(cours);
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

  Widget buildCard(CoursR cours) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(8.0),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          cours.nomCoursR,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        children: [
          ListTile(
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
            trailing: ElevatedButton.icon(
              onPressed: () {
               // deleteCours(cours.pdff); // Ici, j'ai utilisé le champ 'pdff' comme ID, vous pouvez ajuster cela en fonction de votre besoin
              },
              icon: Icon(Icons.delete),
              label: Text('Supprimer'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
