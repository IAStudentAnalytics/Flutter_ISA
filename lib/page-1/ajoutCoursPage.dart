import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pim/page-1/coursPage.dart';
import 'package:pim/services/coursRecService.dart';
import 'package:file_picker/file_picker.dart';
import 'side_menu.dart';

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
          _afficherErreur('Failed to select file: $e');
        }
      }
    }
  }

  Future<void> _ajouterCours() async {
    if (_selectedChapter == null) {
      _afficherErreur('Please select a chapter.');
      return;
    }

    if (_descriptionController.text.isEmpty) {
      _afficherErreur('Please enter a description.');
      return;
    }
    if (_pdfBytes == null) {
      _afficherErreur('Please select a PDF file.');
      return;
    }

    try {
      await CoursService.addCours(
          _selectedChapter!, _descriptionController.text, _pdfBytes!);

      //_afficherSucces('Cours ajouté avec succès.');
      _afficherSucces(context, 'Course added successfully.');

      _resetState();
    } catch (error) {
      _afficherErreur('Failed to add course: $error');
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
          title: Text('Success'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer l'alerte
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CoursPage()), // Remplacez CoursPage par le nom de votre interface
                );
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
   appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text('AddCours'),
      ),
      drawer: SideMenu(onMenuItemClicked: (int) {}),
     
      body: Stack(
        children: [
          Container(
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
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width > 600 ? 430.0 : 120.0,
                    MediaQuery.of(context).size.width > 600 ? 150.0 : 90.0,
                    0.0,
                    0.0,
                  ),
                  child: Text(
                    'Add a course',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width > 600
                          ? 430.0
                          : 130.0),
                  child: Image.asset(
                    'assets/ok.png',
                    width: 150,
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width > 600
                          ? 420.0
                          : 70.0),
                  child: DropdownButton<String>(
                    value: _selectedChapter,
                    hint: Text(
                      'Choose a chapter',
                      style: TextStyle(color: Colors.white),
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
                    MediaQuery.of(context).size.width > 600 ? 20.0 : 20.0,
                    0.0,
                    MediaQuery.of(context).size.width > 600 ? 600.0 : 20.0,
                    0.0,
                  ),
                  child: TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width > 600
                          ? 450.0
                          : 125.0),
                  child: ElevatedButton(
                    onPressed: _pickPDF,
                    child: Text(
                      'Select PDF',
                      style: MediaQuery.of(context).size.width < 600
                          ? TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 30)
                          : TextStyle(fontSize: 20),
                    ),
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
                          'Selected file: $_fileName',
                          style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width > 600
                          ? 450.0
                          : 130.0),
                  child: ElevatedButton(
                    onPressed: _ajouterCours,
                    child: Text(
                      'Add Cours',
                      style: MediaQuery.of(context).size.width < 600
                          ? TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 33)
                          : TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

