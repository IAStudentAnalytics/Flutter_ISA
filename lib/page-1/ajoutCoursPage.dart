//VERSION TEMCHIIIIIIIIIIIIIIIIIIIIIIIII
/*import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pim/services/coursRecService.dart';
import 'package:file_picker/file_picker.dart';

class AjoutCoursPage extends StatefulWidget {
  @override
  _AjoutCoursPageState createState() => _AjoutCoursPageState();
}

class _AjoutCoursPageState extends State<AjoutCoursPage> {
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _pdfBytes;
  String? _selectedChapter;
  String? _fileName;

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        _pdfBytes = file.bytes;
        _fileName = file.name;
      });
    } else {
      // L'utilisateur a annulé la sélection
    }
  }

  Future<void> _ajouterCours() async {
    if (_pdfBytes == null || _selectedChapter == null || _descriptionController.text.isEmpty) {
      _afficherErreur('Veuillez remplir tous les champs.');
      return;
    }

    try {
      await CoursService.addCours(_selectedChapter!, _descriptionController.text, _pdfBytes!);

      _afficherSucces('Cours ajouté avec succès.');

      _resetState();

    } catch (error) {
      _afficherErreur('Échec de l\'ajout du cours: $error');
    }
  }

  void _afficherErreur(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer l'alerte
              },
            ),
          ],
        );
      },
    );
  }

  void _afficherSucces(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Succès'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer l'alerte
              },
            ),
          ],
        );
      },
    );
  }

  void _resetState() {
    _descriptionController.clear();
    _pdfBytes = null;
    _selectedChapter = null;
    _fileName = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: Image.asset(
              'assets/pim11.png',
              width: 100,
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: _selectedChapter,
                    hint: Text('Choisir un chapitre'),
                    items: [
                      "Les classes et les objets",
                      "L'héritage",
                      "Le polymorphisme",
                      "Les interfaces",
                      "Encapsulation"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedChapter = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickPDF,
                    child: Text('Sélectionner un PDF'),
                  ),
                  SizedBox(height: 10),
                  if (_fileName != null)
                    Row(
                      children: [
                        Icon(Icons.picture_as_pdf, color: Colors.red),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Fichier sélectionné: $_fileName',
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _ajouterCours,
                    child: Text('Ajouter Cours'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pim/page-1/coursPage.dart';
import 'package:pim/services/coursRecService.dart';
import 'package:file_picker/file_picker.dart';

class AjoutCoursPage extends StatefulWidget {
  @override
  _AjoutCoursPageState createState() => _AjoutCoursPageState();
}

class _AjoutCoursPageState extends State<AjoutCoursPage> {
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _pdfBytes;
  String? _selectedChapter;
  String? _fileName;
  //fonction sur le web
/*
  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        _pdfBytes = file.bytes;
        _fileName = file.name;
      });
    } 
  }*/
  Future<void> _pickPDF() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    PlatformFile file = result.files.first;

    if (kIsWeb) {
      // Web version
      setState(() {
        _pdfBytes = file.bytes;
        _fileName = file.name;
      });
    } else {
      // SDK version
      final filePath = file.path!; // Use non-null assertion (!)

      try {
        final bytes = await File(filePath).readAsBytes();

        setState(() {
          _pdfBytes = bytes;
          _fileName = file.name;
        });
      } on FileSystemException catch (e) {
        _afficherErreur('Échec de la sélection du fichier: $e');
      }
    }
  }
}
//fonction sur SDK 
/*
  Future<void> _pickPDF() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    PlatformFile file = result.files.first;
    final filePath = file.path!; // Use non-null assertion (!)

    try {
      final bytes = await File(filePath).readAsBytes();

      setState(() {
        _pdfBytes = bytes;
        _fileName = file.name;
      });
    } on FileSystemException catch (e) {
      _afficherErreur('Échec de la sélection du fichier: $e');
    }
  }
}*/


  Future<void> _ajouterCours() async {

if (_selectedChapter == null) {
  _afficherErreur('Veuillez sélectionner un chapitre.');
  return;
}

if (_descriptionController.text.isEmpty) {
  _afficherErreur('Veuillez entrer une description.');
  return;
}
if (_pdfBytes == null) {
  _afficherErreur('Veuillez sélectionner un fichier PDF.');
  return;
}


    try {
      await CoursService.addCours(_selectedChapter!, _descriptionController.text, _pdfBytes!);

      //_afficherSucces('Cours ajouté avec succès.');
      _afficherSucces(context, 'Cours ajouté avec succès.');


      _resetState();

    } catch (error) {
      _afficherErreur('Échec de l\'ajout du cours: $error');
    }
  }

  void _afficherErreur(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer l'alerte
              },
            ),
          ],
        );
      },
    );
  }
void _afficherSucces(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Succès'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Fermer l'alerte
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CoursPage()), // Remplacez CoursPage par le nom de votre interface
              );
            },
          ),
        ],
      );
    },
  );
}

/*
  void _afficherSucces(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Succès'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer l'alerte
              },
            ),
          ],
        );
      },
    );
  }*/

  void _resetState() {
    _descriptionController.clear();
    _pdfBytes = null;
    _selectedChapter = null;
    _fileName = null;
  }
  @override
Widget build(BuildContext context) {
 return Scaffold(
  
   body: Padding(
    padding: EdgeInsets.only(left: 00.0), // Décalage vers la gauche
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 157, 14, 14),
            Color.fromARGB(255, 157, 14, 14),
          ],
          stops: [0, 1],
        ),
        image: DecorationImage(
          image: AssetImage('assets/bajoutt.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15),
      /*boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 119, 14, 14).withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],*/
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start, // Aligner le contenu à gauche
        children: [
     Padding(
  padding: EdgeInsets.fromLTRB(
    MediaQuery.of(context).size.width > 600 ? 400.0 : 70.0, // Décalage horizontal
    MediaQuery.of(context).size.width > 600 ? 150.0 : 70.0, // Décalage vers le haut pour les grands écrans, sinon pour les petits écrans
    0.0, // Décalage horizontal
    0.0, // Pas de décalage vers le bas
  ),
  child: Text(
    'Ajouter votre cours',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
  ),
),

          SizedBox(height: 20),

      Padding(
  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width > 600 ? 430.0 : 130.0),// Décalage vers la gauche et vers la droite
  child:Image.asset(
            'assets/ok.png', // Ajouter le chemin de votre nouvelle image
            width: 150, // Adapter la largeur selon votre besoin
          ),
),
          SizedBox(height: 40),
          
         
           Padding(
  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width > 600 ? 410.0 : 80.0),// Décalage vers la gauche et vers la droite
  child:
          DropdownButton<String>(
            value: _selectedChapter,
           hint: Text(
    'Choisir un chapitre',
    style: TextStyle(color: Color.fromARGB(255, 119, 14, 14)),
  ),
            items: [
              "Les classes et les objets",
              "L'héritage",
              "Le polymorphisme",
              "Les interfaces",
              "Encapsulation"
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedChapter = newValue;
              });
            },
          ),
           ),
          SizedBox(height: 20),
Padding(
  padding: EdgeInsets.fromLTRB(
    MediaQuery.of(context).size.width > 600 ? 20.0 : 20.0, // Décalage horizontal à gauche
    0.0, // Pas de décalage vers le haut
    MediaQuery.of(context).size.width > 600 ? 600.0 : 20.0, // Décalage horizontal à droite
    0.0, // Pas de décalage vers le bas
  ),
  child: TextField(
    controller: _descriptionController,
    decoration: InputDecoration(
      labelText: 'Description',
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      fillColor: Color.fromARGB(255, 255, 255, 255),
      filled: true,
    ),
  ),
),

          SizedBox(height: 20),
             Padding(
 padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width > 600 ? 410.0 : 100.0),// Décalage vers la gauche et vers la droite
  child:
          ElevatedButton(
            onPressed: _pickPDF,
            child: Text('Sélectionner un PDF'),
          ),
       
             ),
                SizedBox(height: 10),
          if (_fileName != null)
            Row(
              children: [
                Icon(Icons.picture_as_pdf, color: Colors.red),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Fichier sélectionné: $_fileName',
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          SizedBox(height: 20),
               Padding(
  //padding: EdgeInsets.only(left: 430.0, right: 20.0), // Décalage vers la gauche et vers la droite
  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width > 600 ? 430.0 : 130.0),
  child:
          ElevatedButton(
            onPressed: _ajouterCours,
            child: Text('Ajouter Cours'),
          ),
               ),
        ],
      ),
    ),
  ),
);

}
}

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: Image.asset(
              'assets/pim11.png',
              width: 100,
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ajouter votre cours',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  'assets/images/livre.png', // Ajouter le chemin de votre nouvelle image
                  width: 150, // Adapter la largeur selon votre besoin
                ),
                SizedBox(height: 20),
                  DropdownButton<String>(
                    value: _selectedChapter,
                    hint: Text('Choisir un chapitre'),
                    items: [
                      "Les classes et les objets",
                      "L'héritage",
                      "Le polymorphisme",
                      "Les interfaces",
                      "Encapsulation"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedChapter = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickPDF,
                    child: Text('Sélectionner un PDF'),
                  ),
                  SizedBox(height: 10),
                  if (_fileName != null)
                    Row(
                      children: [
                        Icon(Icons.picture_as_pdf, color: Colors.red),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Fichier sélectionné: $_fileName',
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _ajouterCours,
                    child: Text('Ajouter Cours'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/
/*import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pim/services/coursRecService.dart';
import 'package:file_picker/file_picker.dart';

class AjoutCoursPage extends StatefulWidget {
  @override
  _AjoutCoursPageState createState() => _AjoutCoursPageState();
}

class _AjoutCoursPageState extends State<AjoutCoursPage> {
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _pdfBytes;
  String? _selectedChapter;
  String? _fileName;

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        _pdfBytes = file.bytes;
        _fileName = file.name;
      });
    } else {
      // L'utilisateur a annulé la sélection
    }
  }

  Future<void> _ajouterCours() async {
    if (_pdfBytes == null || _selectedChapter == null || _descriptionController.text.isEmpty) {
      _afficherErreur('Veuillez remplir tous les champs.');
      return;
    }

    try {
      await CoursService.addCours(_selectedChapter!, _descriptionController.text, _pdfBytes!);

      _afficherSucces('Cours ajouté avec succès.');

      _resetState();

    } catch (error) {
      _afficherErreur('Échec de l\'ajout du cours: $error');
    }
  }

  void _afficherErreur(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer l'alerte
              },
            ),
          ],
        );
      },
    );
  }

  void _afficherSucces(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Succès'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer l'alerte
              },
            ),
          ],
        );
      },
    );
  }

  void _resetState() {
    _descriptionController.clear();
    _pdfBytes = null;
    _selectedChapter = null;
    _fileName = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: Image.asset(
              'assets/pim11.png',
              width: 100,
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: _selectedChapter,
                    hint: Text('Choisir un chapitre'),
                    items: [
                      "Les classes et les objets",
                      "L'héritage",
                      "Le polymorphisme",
                      "Les interfaces",
                      "Encapsulation"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedChapter = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickPDF,
                    child: Text('Sélectionner un PDF'),
                  ),
                  SizedBox(height: 10),
                  if (_fileName != null)
                    Row(
                      children: [
                        Icon(Icons.picture_as_pdf, color: Colors.red),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Fichier sélectionné: $_fileName',
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _ajouterCours,
                    child: Text('Ajouter Cours'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/



/*tadhla3 fel SDK
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pim/services/coursRecService.dart';
import 'package:file_picker/file_picker.dart';

class AjoutCoursPage extends StatefulWidget {
  @override
  _AjoutCoursPageState createState() => _AjoutCoursPageState();
}

class _AjoutCoursPageState extends State<AjoutCoursPage> {
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _pdfBytes;
  String? _selectedChapter;
  String? _fileName;

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        _pdfBytes = file.bytes;
        _fileName = file.name;
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> _ajouterCours() async {
    if (_pdfBytes == null || _selectedChapter == null || _descriptionController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Veuillez sélectionner un PDF, choisir un chapitre et entrer une description'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fermer l'alerte
                },
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      await CoursService.addCours(_selectedChapter!, _descriptionController.text, _pdfBytes!);
      
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Succès'),
            content: Text('Cours ajouté avec succès'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fermer l'alerte
                },
              ),
            ],
          );
        },
      );

      setState(() {
        _descriptionController.clear();
        _pdfBytes = null;
        _selectedChapter = null;
        _fileName = null;
      });

    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Échec de l\'ajout du cours: $error'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fermer l'alerte
                },
              ),
            ],
          );
        },
      );
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        Positioned(
          top: 20,
          left: 20,
          child: Image.asset(
            'assets/pim11.png',
            width: 100,
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: _selectedChapter,
                  hint: Text('Choisir un chapitre'),
                  items: <String>[
                    "Les classes et les objets",
                    "L'héritage",
                    "Le polymorphisme",
                    "Les interfaces",
                    "Encapsulation"
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedChapter = newValue;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickPDF,
                  child: Text('Sélectionner un PDF'),
                ),
                SizedBox(height: 10),
                if (_fileName != null)
                  Row(
                    children: [
                      Icon(Icons.picture_as_pdf, color: Colors.red),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Fichier sélectionné: $_fileName',
                          style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _ajouterCours,
                  child: Text('Ajouter Cours'),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}
*/
//shih fel web
/*import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pim/services/coursRecService.dart';

// Import the file picker package
import 'package:file_picker/file_picker.dart';

class AjoutCoursPage extends StatefulWidget {
  @override
  _AjoutCoursPageState createState() => _AjoutCoursPageState();
}

class _AjoutCoursPageState extends State<AjoutCoursPage> {
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _pdfBytes;
  String? _selectedChapter;
  String? _fileName;

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        _pdfBytes = file.bytes;
        _fileName = file.name;
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> _ajouterCours() async {
    if (_pdfBytes == null || _selectedChapter == null || _descriptionController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Veuillez sélectionner un PDF, choisir un chapitre et entrer une description'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fermer l'alerte
                },
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      await CoursService.addCours(_selectedChapter!, _descriptionController.text, _pdfBytes!);
      
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Succès'),
            content: Text('Cours ajouté avec succès'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fermer l'alerte
                },
              ),
            ],
          );
        },
      );

      setState(() {
        _descriptionController.clear();
        _pdfBytes = null;
        _selectedChapter = null;
        _fileName = null;
      });

    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Échec de l\'ajout du cours: $error'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fermer l'alerte
                },
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: Image.asset(
              'assets/pim11.png',
              width: 100,
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButton<String>(
                  value: _selectedChapter,
                  hint: Text('Choisir un chapitre'),
                  items: <String>[
                    "Les classes et les objets",
                    "L'héritage",
                    "Le polymorphisme",
                    "Les interfaces",
                    "Encapsulation"
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedChapter = newValue;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickPDF,
                  child: Text('Sélectionner un PDF'),
                ),
                SizedBox(height: 10),
                if (_fileName != null)
                  Row(
                    children: [
                      Icon(Icons.picture_as_pdf, color: Colors.red), // Icône PDF
                      SizedBox(width: 10),
                      Text(
                        'Fichier sélectionné: $_fileName',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _ajouterCours,
                  child: Text('Ajouter Cours'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/
