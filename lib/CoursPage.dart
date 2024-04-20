/*import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  List<dynamic> coursList = [];
  bool isLoading = true;
  String? pdfPath;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      setState(() {
        coursList = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  Future<File> _downloadFile(String url, String filename) async {
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  void initState() {
    super.initState();
    getCours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: coursList.length,
              itemBuilder: (context, index) {
                var cours = coursList[index];
                return ListTile(
                  title: Text(cours['nomCoursR']),
                  subtitle: Text(cours['pdff']),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      try {
                        var file = await _downloadFile(
                            cours['pdff'], '${cours['nomCoursR']}.pdf');
                        pdfPath = file.path;
                        setState(() {});
                      } catch (e) {
                        print('Erreur: $e');
                      }
                    },
                    child: Text('Afficher PDF'),
                  ),
                );
              },
            ),
      floatingActionButton: pdfPath != null
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewPage(
                      pdfPath: pdfPath!,
                    ),
                  ),
                );
              },
              child: Icon(Icons.picture_as_pdf),
            )
          : null,
    );
  }
}

class PdfViewPage extends StatelessWidget {
  final String pdfPath;

  PdfViewPage({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfPath,
        onError: (error) {
          print(error.toString());
        },
        onPageChanged: (page, total) {
          print('Page $page of $total');
        },
      ),
    );
  }
}*/
//hedhi lech doneya 
/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  Map<String, List<dynamic>> coursList = {};
  bool isLoading = true;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      Map<String, List<dynamic>> map = {};
      for (var item in list) {
        if (!map.containsKey(item['nomCoursR'])) {
          map[item['nomCoursR']] = [];
        }
        map[item['nomCoursR']]?.add(item);
      }
      setState(() {
        coursList = map;
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  Future<void> deleteCours(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:9090/compilateur/cours/$id'));

    if (response.statusCode == 200) {
      setState(() {
        getCours();
      });
    } else {
      throw Exception('Échec de la suppression du cours');
    }
  }

  void openPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
  }

  @override
  void initState() {
    super.initState();
    getCours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/pim11.png',
              width: 150,
            ),
          ),
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
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: coursList.keys.length,
                    itemBuilder: (context, index) {
                      var key = coursList.keys.elementAt(index);
                      var list = coursList[key];
                      return Card(
                        color: Colors.white,
                        margin: EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          initiallyExpanded: true, // Les cartes sont ouvertes par défaut
                          title: Text(key),
                          children: list?.map((cours) {
                            return ListTile(
                              title: Align(
                                alignment: Alignment.centerLeft, // Alignement à gauche
                                child: TextButton(
                                  onPressed: () {
                                    openPdf(cours['pdff']);
                                  },
                                  child: Text(
                                    cours['description'],
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      deleteCours(cours['_id']);
                                    },
                                    child: Text('Supprimer'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red, // background
                                      onPrimary: Colors.white, // foreground
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList() ?? [],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}*/
/* faza teb3a moch doneya 
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Liste des Cours'),
    ),
    body: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset(
            'assets/pim11.png',
            width: 150,
          ),
        ),
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
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: coursList.keys.length,
                  itemBuilder: (context, index) {
                    var key = coursList.keys.elementAt(index);
                    var list = coursList[key];
                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        initiallyExpanded: true, // Les cartes sont ouvertes par défaut
                        title: ListTile(
                          leading: Icon(Icons.book), // Ajout d'une icône de livre
                          title: Text(key),
                        ),
                        children: list?.map((cours) {
                          return ListTile(
                            title: Align(
                              alignment: Alignment.centerLeft, // Alignement à gauche
                              child: TextButton(
                                onPressed: () {
                                  openPdf(cours['pdff']);
                                },
                                child: Text(
                                  cours['description'],
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    deleteCours(cours['_id']);
                                  },
                                  child: Text('Supprimer'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red, // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList() ?? [],
                      ),
                    );
                  },
                ),
        ),
      ],
    ),
  );
}

*/


/*ahsen wehed */
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  Map<String, List<dynamic>> coursList = {};
  bool isLoading = true;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      Map<String, List<dynamic>> map = {};
      for (var item in list) {
        if (!map.containsKey(item['nomCoursR'])) {
          map[item['nomCoursR']] = [];
        }
        map[item['nomCoursR']]?.add(item);
      }
      setState(() {
        coursList = map;
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  Future<void> deleteCours(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:9090/compilateur/cours/$id'));

    if (response.statusCode == 200) {
      setState(() {
        getCours();
      });
    } else {
      throw Exception('Échec de la suppression du cours');
    }
  }

  void openPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
  }

  @override
  void initState() {
    super.initState();
    getCours();
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
          : ListView.builder(
              itemCount: coursList.keys.length,
              itemBuilder: (context, index) {
                var key = coursList.keys.elementAt(index);
                var list = coursList[key] ?? []; // Fournir une liste vide si la liste est nulle
                if (index == 0) {
                  return Column(
                    children: [
                       
                      Image.asset(
                        'assets/pim11.png',
                        width: 150,
                      ),
                      buildCard(key, list),
                    ],
                  );
                } else {
                  return buildCard(key, list);
                }
              },
            ),
    ),
  );
}

Widget buildCard(String key, List<dynamic> list) {
  return Card(
    color: Colors.white,
    margin: EdgeInsets.all(8.0),
    child: ExpansionTile(
      initiallyExpanded: true, // Les cartes sont ouvertes par défaut
      title: Text(
        key,
        style: TextStyle(
          color: Colors.black, // Couleur de texte en noir
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      children: list.map((cours) { // Pas besoin de vérifier la nullité ici car nous avons déjà fourni une valeur par défaut
        return ListTile(
          title: Align(
            alignment: Alignment.centerLeft, // Alignement à gauche
            child: TextButton(
              onPressed: () {
                openPdf(cours['pdff']);
              },
              child: Text(
                cours['description'],
                style: TextStyle(
                  color: Colors.black, // Couleur de texte en noir
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          trailing: ElevatedButton.icon(
            onPressed: () {
              deleteCours(cours['_id']);
            },
                            icon: Icon(Icons.delete),
                            label: Text('Supprimer'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // background
                              onPrimary: Colors.white, // foreground
                            ),
                          ),
                        );
                      }).toList() ?? [],
    ),
  );
}
}
  /*
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
          : ListView.builder(
              itemCount: coursList.keys.length,
              itemBuilder: (context, index) {
                var key = coursList.keys.elementAt(index);
                var list = coursList[key];
                return Row(
                  children: [
                    Image.asset(
                      'assets/pim11.png',
                      width: 50,
                    ),
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        margin: EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          initiallyExpanded: true, // Les cartes sont ouvertes par défaut
                          title: Text(
                            key,
                            style: TextStyle(
                              color: Colors.black, // Couleur de texte en noir
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          children: list?.map((cours) {
                            return ListTile(
                              title: Align(
                                alignment: Alignment.centerLeft, // Alignement à gauche
                                child: TextButton(
                                  onPressed: () {
                                    openPdf(cours['pdff']);
                                  },
                                  child: Text(
                                    cours['description'],
                                    style: TextStyle(
                                      color: Colors.black, // Couleur de texte en noir
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                              trailing: ElevatedButton.icon(
                                onPressed: () {
                                  deleteCours(cours['_id']);
                                },
                                icon: Icon(Icons.delete),
                                label: Text('Supprimer'),
                              ),
                            );
                          }).toList() ?? [],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    ),
  );
}
}*/


/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  Map<String, List<dynamic>> coursList = {};
  bool isLoading = true;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      Map<String, List<dynamic>> map = {};
      for (var item in list) {
        if (!map.containsKey(item['nomCoursR'])) {
          map[item['nomCoursR']] = [];
        }
        map[item['nomCoursR']]?.add(item);
      }
      setState(() {
        coursList = map;
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  Future<void> deleteCours(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:9090/compilateur/cours/$id'));

    if (response.statusCode == 200) {
      setState(() {
        getCours();
      });
    } else {
      throw Exception('Échec de la suppression du cours');
    }
  }

  void openPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
  }

  @override
  void initState() {
    super.initState();
    getCours();
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
            : ListView.builder(
                itemCount: coursList.keys.length,
                itemBuilder: (context, index) {
                  var key = coursList.keys.elementAt(index);
                  var list = coursList[key];
                  return Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(8.0),
                    child: ExpansionTile(
                      initiallyExpanded: true, // Les cartes sont ouvertes par défaut
                      title: Text(
                        key,
                        style: TextStyle(
                          color: Colors.black, // Couleur de texte en noir
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      children: list?.map((cours) {
                        return ListTile(
                          title: Align(
                            alignment: Alignment.centerLeft, // Alignement à gauche
                            child: TextButton(
                              onPressed: () {
                                openPdf(cours['pdff']);
                              },
                              child: Text(
                                cours['description'],
                                style: TextStyle(
                                  color: Colors.black, // Couleur de texte en noir
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          trailing: ElevatedButton.icon(
                            onPressed: () {
                              deleteCours(cours['_id']);
                            },
                            icon: Icon(Icons.delete),
                            label: Text('Supprimer'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // background
                              onPrimary: Colors.white, // foreground
                            ),
                          ),
                        );
                      }).toList() ?? [],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
*/
/*carddd
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  Map<String, List<dynamic>> coursList = {};
  bool isLoading = true;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      Map<String, List<dynamic>> map = {};
      for (var item in list) {
        if (!map.containsKey(item['nomCoursR'])) {
          map[item['nomCoursR']] = [];
        }
        map[item['nomCoursR']]?.add(item);
      }
      setState(() {
        coursList = map;
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  Future<void> deleteCours(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:9090/compilateur/cours/$id'));

    if (response.statusCode == 200) {
      setState(() {
        getCours();
      });
    } else {
      throw Exception('Échec de la suppression du cours');
    }
  }

  void openPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
  }

  @override
  void initState() {
    super.initState();
    getCours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/pim11.png',
              width: 150,
            ),
          ),
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
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: coursList.keys.length,
                    itemBuilder: (context, index) {
                      var key = coursList.keys.elementAt(index);
                      var list = coursList[key];
                      return Card(
                        color: Colors.white,
                        margin: EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          initiallyExpanded: true, // Les cartes sont ouvertes par défaut
                          title: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              key,
                              style: TextStyle(
                                fontWeight: FontWeight.bold, // Texte en gras
                              ),
                            ),
                          ),
                          children: list?.map((cours) {
                            return ListTile(
                              title: Align(
                                alignment: Alignment.centerLeft, // Alignement à gauche
                                child: TextButton(
                                  onPressed: () {
                                    openPdf(cours['pdff']);
                                  },
                                  child: Text(
                                    cours['description'],
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      deleteCours(cours['_id']);
                                    },
                                    child: Text('Supprimer'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red, // background
                                      onPrimary: Colors.white, // foreground
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList() ?? [],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}*/
/*temchi 80%
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  Map<String, List<dynamic>> coursList = {};
  bool isLoading = true;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      Map<String, List<dynamic>> map = {};
      for (var item in list) {
        if (!map.containsKey(item['nomCoursR'])) {
          map[item['nomCoursR']] = [];
        }
        map[item['nomCoursR']]?.add(item);
      }
      setState(() {
        coursList = map;
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  Future<void> deleteCours(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:9090/compilateur/cours/$id'));

    if (response.statusCode == 200) {
      setState(() {
        getCours();
      });
    } else {
      throw Exception('Échec de la suppression du cours');
    }
  }

  void openPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
  }

  @override
  void initState() {
    super.initState();
    getCours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/pim11.png',
              width: 150,
            ),
          ),
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
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: coursList.keys.length,
                    itemBuilder: (context, index) {
                      var key = coursList.keys.elementAt(index);
                      var list = coursList[key];
                      return Column(
                        children: [
                          Text(
                            key,
                            style: TextStyle(
                              fontWeight: FontWeight.bold, // Texte en gras
                              fontSize: 20, // Taille du texte
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.all(8.0),
                            child: ExpansionTile(
                              initiallyExpanded: true, // Les cartes sont ouvertes par défaut
                              title: Text('Cliquez pour voir les cours'),
                              children: list?.map((cours) {
                                return ListTile(
                                  title: Align(
                                    alignment: Alignment.centerLeft, // Alignement à gauche
                                    child: TextButton(
                                      onPressed: () {
                                        openPdf(cours['pdff']);
                                      },
                                      child: Text(
                                        cours['description'],
                                        style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(width: 8),
                                      ElevatedButton(
                                        onPressed: () {
                                          deleteCours(cours['_id']);
                                        },
                                        child: Text('Supprimer'),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red, // background
                                          onPrimary: Colors.white, // foreground
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList() ?? [],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}*/



/*hedhi jawha behi ama maghir image*/
/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  Map<String, List<dynamic>> coursList = {};
  bool isLoading = true;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      Map<String, List<dynamic>> map = {};
      for (var item in list) {
        if (!map.containsKey(item['nomCoursR'])) {
          map[item['nomCoursR']] = [];
        }
        map[item['nomCoursR']]?.add(item);
      }
      setState(() {
        coursList = map;
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  Future<void> deleteCours(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:9090/compilateur/cours/$id'));

    if (response.statusCode == 200) {
      setState(() {
        getCours();
      });
    } else {
      throw Exception('Échec de la suppression du cours');
    }
  }

  void openPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
  }

  @override
  void initState() {
    super.initState();
    getCours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours'),
      ),
      body: Container(
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
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: coursList.keys.length,
                itemBuilder: (context, index) {
                  var key = coursList.keys.elementAt(index);
                  var list = coursList[key];
                  return Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(8.0),
                    child: ExpansionTile(
                      title: Text(key),
                      children: list?.map((cours) {
                        return ListTile(
                          title: TextButton(
                            onPressed: () {
                              openPdf(cours['pdff']);
                            },
                            child: Text(
                              cours['description'],
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  deleteCours(cours['_id']);
                                },
                                child: Text('Supprimer'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList() ?? [],
                    ),
                  );
                },
              ),
      ),
    );
  }
}*/

/* hedhi lekhra blech url
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  Map<String, List<dynamic>> coursList = {};
  bool isLoading = true;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      Map<String, List<dynamic>> map = {};
      for (var item in list) {
        if (!map.containsKey(item['nomCoursR'])) {
          map[item['nomCoursR']] = [];
        }
        map[item['nomCoursR']]?.add(item);
      }
      setState(() {
        coursList = map;
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  Future<void> deleteCours(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:9090/compilateur/cours/$id'));

    if (response.statusCode == 200) {
      setState(() {
        getCours();
      });
    } else {
      throw Exception('Échec de la suppression du cours');
    }
  }

  void openPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
  }

  @override
  void initState() {
    super.initState();
    getCours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours'),
      ),
      body: Container(
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
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: coursList.keys.length,
                itemBuilder: (context, index) {
                  var key = coursList.keys.elementAt(index);
                  var list = coursList[key];
                  return Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(8.0),
                    child: ExpansionTile(
                      title: Text(key),
                      children: list?.map((cours) {
                        return ListTile(
                          //title: Text(cours['pdff']),
                          subtitle: Text(cours['description']), // Ajout de la description
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  openPdf(cours['pdff']);
                                },
                                child: Text('Ouvrir PDF'),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  deleteCours(cours['_id']);
                                },
                                child: Text('Supprimer'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList() ?? [],
                    ),
                  );
                },
              ),
      ),
    );
  }
}*/

/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  Map<String, List<dynamic>> coursList = {};
  bool isLoading = true;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      Map<String, List<dynamic>> map = {};
      for (var item in list) {
        if (!map.containsKey(item['nomCoursR'])) {
          map[item['nomCoursR']] = [];
        }
        map[item['nomCoursR']]?.add(item);
      }
      setState(() {
        coursList = map;
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  Future<void> deleteCours(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:9090/compilateur/cours/$id'));

    if (response.statusCode == 200) {
      setState(() {
        getCours();
      });
    } else {
      throw Exception('Échec de la suppression du cours');
    }
  }

  void openPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
  }

  @override
  void initState() {
    super.initState();
    getCours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours'),
      ),
      body: Container(
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
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: coursList.keys.length,
                itemBuilder: (context, index) {
                  var key = coursList.keys.elementAt(index);
                  var list = coursList[key];
                  return Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(8.0),
                    child: ExpansionTile(
                      title: Text(key),
                      children: list?.map((cours) {
                        return ListTile(
                          title: Text(cours['pdff']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  openPdf(cours['pdff']);
                                },
                                child: Text('Ouvrir PDF'),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  deleteCours(cours['_id']);
                                },
                                child: Text('Supprimer'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList() ?? [],
                    ),
                  );
                },
              ),
      ),
    );
  }
}*/

/*hedhi lekhra 
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  List<dynamic> coursList = [];
  bool isLoading = true;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      setState(() {
        coursList = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  Future<void> deleteCours(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:9090/compilateur/cours/$id'));

    if (response.statusCode == 200) {
      setState(() {
        getCours();
      });
    } else {
      throw Exception('Échec de la suppression du cours');
    }
  }

  void openPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
  }

  @override
  void initState() {
    super.initState();
    getCours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours'),
      ),
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
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: coursList.length,
                  itemBuilder: (context, index) {
                    var cours = coursList[index];
                    return ListTile(
                      title: Text(cours['nomCoursR']),
                      subtitle: Text(cours['pdff']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              openPdf(cours['pdff']);
                            },
                            child: Text('Ouvrir PDF'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              deleteCours(cours['_id']);
                            },
                            child: Text('Supprimer'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // background
                              onPrimary: Colors.white, // foreground
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
*/
/*shihaaaaaaaaa
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  List<dynamic> coursList = [];
  bool isLoading = true;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      setState(() {
        coursList = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  Future<void> deleteCours(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:9090/compilateur/cours/$id'));

    if (response.statusCode == 200) {
      setState(() {
        getCours();
      });
    } else {
      throw Exception('Échec de la suppression du cours');
    }
  }

  void openPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
  }

  @override
  void initState() {
    super.initState();
    getCours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: coursList.length,
              itemBuilder: (context, index) {
                var cours = coursList[index];
                return ListTile(
                  title: Text(cours['nomCoursR']),
                  subtitle: Text(cours['pdff']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          openPdf(cours['pdff']);
                        },
                        child: Text('Ouvrir PDF'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          deleteCours(cours['_id']);
                        },
                        child: Text('Supprimer'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // background
                          onPrimary: Colors.white, // foreground
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
*/
/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  List<dynamic> coursList = [];
  bool isLoading = true;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      setState(() {
        coursList = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  void openPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
  }

  Future<void> deleteCours(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:9090/compilateur/cours/$id'));

    if (response.statusCode == 200) {
      setState(() {
        coursList.removeWhere((cours) => cours['id'] == id);
      });
    } else {
      throw Exception('Échec de la suppression du cours');
    }
  }

  @override
  void initState() {
    super.initState();
    getCours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: coursList.length,
              itemBuilder: (context, index) {
                var cours = coursList[index];
                return ListTile(
                  title: Text(cours['nomCoursR']),
                  subtitle: Text(cours['pdff']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          openPdf(cours['pdff']);
                        },
                        child: Text('Ouvrir PDF'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirmation'),
                                content: Text('Voulez-vous vraiment supprimer ce cours ?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Annuler'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteCours(cours['id']); // Remplacez 'id' par le champ d'ID approprié dans votre objet cours
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Supprimer'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Supprimer'),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
*/
/* etudiantttttttt
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  List<dynamic> coursList = [];
  bool isLoading = true;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      setState(() {
        coursList = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  void openPdf(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      print('Erreur : Impossible d\'ouvrir l\'URL $pdfUrl');
    }
  }

  @override
  void initState() {
    super.initState();
    getCours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: coursList.length,
              itemBuilder: (context, index) {
                var cours = coursList[index];
                return ListTile(
                  title: Text(cours['nomCoursR']),
                  subtitle: Text(cours['pdff']),
                  trailing: ElevatedButton(
                    onPressed: () {
                      openPdf(cours['pdff']);
                    },
                    child: Text('Ouvrir PDF'),
                  ),
                );
              },
            ),
    );
  }
}
*/
/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  List<dynamic> coursList = [];
  bool isLoading = true;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      setState(() {
        coursList = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  @override
  void initState() {
    super.initState();
    getCours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: coursList.length,
              itemBuilder: (context, index) {
                var cours = coursList[index];
                return ListTile(
                  title: Text(cours['nomCoursR']),
                  subtitle: Text(cours['pdff']),
                  onTap: () async {
                    if (await canLaunch(cours['pdff'])) {
                      await launch(cours['pdff']);
                    } else {
                      throw 'Could not launch ${cours['pdff']}';
                    }
                  },
                );
              },
            ),
    );
  }
}
*/
/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  List<dynamic> coursList = [];
  bool isLoading = true;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      setState(() {
        coursList = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  @override
  void initState() {
    super.initState();
    getCours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: coursList.length,
              itemBuilder: (context, index) {
                var cours = coursList[index];
                return ListTile(
                  title: Text(cours['nomCoursR']),
                  subtitle: Text(cours['pdff']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfViewPage(
                          pdfUrl: cours['pdff'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class PdfViewPage extends StatelessWidget {
  final String pdfUrl;

  PdfViewPage({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: WebView(
        initialUrl: pdfUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
*/
/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  List<dynamic> coursList = [];
  bool isLoading = true;

  Future<void> getCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/compilateur/cours'));

    if (response.statusCode == 200) {
      setState(() {
        coursList = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  @override
  void initState() {
    super.initState();
    getCours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cours'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: coursList.length,
              itemBuilder: (context, index) {
                var cours = coursList[index];
                return ListTile(
                  title: Text(cours['nomCoursR']),
                  subtitle: Text(cours['pdff']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfViewPage(
                          pdfUrl: cours['pdff'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class PdfViewPage extends StatelessWidget {
  final String pdfUrl;

  PdfViewPage({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: WebView(
        initialUrl: pdfUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}*/


/*
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  String pdfPath = "";


  Future<dynamic> getAllCours() async {
    final baseUrl = 'http://localhost:9090/compilateur/cours';
    final response = await http.get(Uri.parse(baseUrl));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Échec de la récupération des cours: ${response.body}');
    }
  }

  Future<File> _downloadFile(String url, String filename) async {
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cours de Backend'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  final jsonData = await getAllCours();
                  print('Cours list: $jsonData');
                  if (jsonData is List && jsonData.isNotEmpty) {
                    var cours = jsonData[0]; // Prenez le premier cours pour l'exemple
                    var file = await _downloadFile(cours['pdff'], '${cours['nomCoursR']}.pdf');
                    pdfPath = file.path;
                    setState(() {});
                  }
                } catch (e) {
                  print('Erreur lors de la récupération des cours: $e');
                }
              },
              child: Text('Obtenir les cours'),
            ),
            if (pdfPath != null && pdfPath.isNotEmpty)
              Expanded(
                child: PDFView(
                  filePath: pdfPath,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
*/
/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoursPage extends StatefulWidget {
  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  Future<dynamic> getCours(String nomCours) async {
    final response = await http.get(Uri.parse('http://localhost:9090/cours/$nomCours'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Échec de la récupération du cours');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cours de Backend'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  final cours = await getCours('Les classes et les objets');
                  print(cours);
                } catch (e) {
                  print('Erreur: $e');
                }
              },
              child: Text('Les classes et les objets'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final cours = await getCours('L\'héritage');
                  print(cours);
                } catch (e) {
                  print('Erreur: $e');
                }
              },
              child: Text('L\'héritage'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final cours = await getCours('Le polymorphisme');
                  print(cours);
                } catch (e) {
                  print('Erreur: $e');
                }
              },
              child: Text('Le polymorphisme'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final cours = await getCours('Les interfaces');
                  print(cours);
                } catch (e) {
                  print('Erreur: $e');
                }
              },
              child: Text('Les interfaces'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final cours = await getCours('Encapsulation');
                  print(cours);
                } catch (e) {
                  print('Erreur: $e');
                }
              },
              child: Text('Encapsulation'),
            ),
          ],
        ),
      ),
    );
  }
}*/
