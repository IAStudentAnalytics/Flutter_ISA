import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pim/services/coursRecService.dart';


class AjoutCoursPage extends StatefulWidget {
  @override
  _AjoutCoursPageState createState() => _AjoutCoursPageState();
}

class _AjoutCoursPageState extends State<AjoutCoursPage> {
  final TextEditingController _descriptionController = TextEditingController();
  html.File? _pdfFile;
  String? _selectedChapter;
  String? _fileName;

  Future<void> _pickPDF() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '.pdf';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final userFile = uploadInput.files!.first;
      setState(() {
        _pdfFile = userFile;
        _fileName = userFile.name;
      });
    });
  }

  Future<Uint8List> _convertFileToBytes(html.File file) {
    final Completer<Uint8List> completer = Completer<Uint8List>();
    final html.FileReader reader = html.FileReader();
    reader.readAsDataUrl(file);
    reader.onLoadEnd.listen((event) {
      String result = reader.result as String;
      String base64Data = result.substring(result.indexOf(',') + 1);
      completer.complete(base64.decode(base64Data));
    });
    return completer.future;
  }

  Future<void> _ajouterCours() async {
    if (_pdfFile == null || _selectedChapter == null || _descriptionController.text.isEmpty) {
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
      Uint8List pdfBytes = await _convertFileToBytes(_pdfFile!);
      await CoursService.addCours(_selectedChapter!, _descriptionController.text, pdfBytes);
      
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
        _pdfFile = null;
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
                    "le polymorphisme",
                    "Les interfaces",
                    "encapsulation"
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
}
