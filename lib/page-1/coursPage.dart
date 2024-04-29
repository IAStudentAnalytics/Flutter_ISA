
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
    coursList = CoursService.fetchCours();
    coursList.then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  void deleteCours(String id) async {
    try {
      await CoursService.deleteCours(id);
      setState(() {
        coursList = CoursService.fetchCours();
      });
    } catch (error) {
      print('Erreur lors de la suppression du cours: $error');
    }
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
  Map<String, int> countCoursByChapter(Map<String, List<CoursR>> coursMap) {
  Map<String, int> countMap = {};
  coursMap.forEach((key, value) {
    countMap[key] = value.length;
  });
  return countMap;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cours'),
        backgroundColor: Color.fromARGB(255, 237, 46, 46),
      ),
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
                    return GridView.builder(
                      padding: EdgeInsets.all(10.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Nombre de colonnes
                        childAspectRatio: 5 / 2, // Ratio largeur/hauteur des cellules
                      ),
                      itemCount: coursMap.length,
                      itemBuilder: (context, index) {
                        final key = coursMap.keys.elementAt(index);
                        return buildGroupedContainer(key, coursMap[key]!);
                      },
                    );
                  } else {
                    return Center(child: Text('Aucun cours trouvé'));
                  }
                },
              ),
      ),
    );
  }
  Widget buildGroupedContainer(String key, List<CoursR> coursList) {
  Map<String, int> countMap = countCoursByChapter(groupCoursByNomCoursR(coursList));
  int numberOfCours = countMap[key] ?? 0;

  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(key),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: coursList.map((cours) => ListTile(
                  title: Row( // Row here
                    children: [
                      Icon(Icons.picture_as_pdf), // Icon added
                      SizedBox(width: 8), // Added space between icon and text
                      Expanded( // Expanded added
                        child: TextButton( // Changed from Text to TextButton
                          onPressed: () {
                            openPdf(cours.pdff);
                          },
                          child: Text(cours.description),
                        ),
                      ),
                    ],
                  ),
                  trailing: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmation'),
                            content: Text('Êtes-vous sûr de vouloir supprimer ce cours ?'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Annuler'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Fermer l'alerte
                                },
                              ),
                              TextButton(
                                child: Text('Confirmer'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Fermer l'alerte
                                  deleteCours(cours.id); 
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                   /* icon: Icon(Icons.delete),
                    label: Text('Supprimer'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,*/
                        icon: Icon(
    Icons.delete,
    size: 12.0, // Réduisez la taille de l'icône
  ),
  label: Text(
    'Supprimer',
    style: TextStyle(
      fontSize: 10.0, // Réduisez la taille du texte
    ),
  ),
  style: ElevatedButton.styleFrom(
    primary: Colors.red,
    onPrimary: Colors.white,
  
                    ),
                  ),
                )).toList(),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Fermer'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fermer l'alerte
                },
              ),
            ],
          );
        },
        
      );
    },
    child: Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 242, 134, 126),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      'assets/javaz.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    key,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre de cours : $numberOfCours',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}
  
/*
  Widget buildGroupedContainer(String key, List<CoursR> coursList) {
      Map<String, int> countMap = countCoursByChapter(groupCoursByNomCoursR(coursList));
      int numberOfCours = countMap[key] ?? 0;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(key),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // NEW
                  children: coursList.map((cours) => ListTile(
                    title: Text(cours.description),
                    trailing: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirmation'),
                              content: Text('Êtes-vous sûr de vouloir supprimer ce cours ?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Annuler'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Fermer l'alerte
                                  },
                                ),
                                TextButton(
                                  child: Text('Confirmer'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Fermer l'alerte
                                    deleteCours(cours.id); 
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete),
                      label: Text('Supprimer'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                      ),
                    ),
                  )).toList(),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Fermer'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Fermer l'alerte
                  },
                ),
              ],
            );
          },
        );
      },
    child: Column(
  children: [
    Expanded(
      flex: 1, // Ajouté ici
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 242, 134, 126),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/javaz.png', // Remplacez par le chemin de votre image
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft, // Alignement à gauche
              padding: EdgeInsets.all(8.0), // Ajoutez du padding si nécessaire
              child: Text(
                key,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    Expanded(
      flex: 1, // Ajouté ici
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre de cours : $numberOfCours',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ],
),
        );
  }
}*/
