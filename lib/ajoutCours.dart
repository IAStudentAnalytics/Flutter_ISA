/*import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    final String apiUrl = 'http://localhost:9090/compilateur/run-code';
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['nomCoursR'] = _selectedChapter!;
    request.fields['description'] = _descriptionController.text;
    Uint8List pdfBytes = await _convertFileToBytes(_pdfFile!);
    request.files.add(http.MultipartFile.fromBytes('source', pdfBytes, filename: 'file.pdf', contentType: MediaType('application', 'pdf')));

    var response = await request.send();

    if (response.statusCode == 200) {
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
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Échec de l\'ajout du cours'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
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
    body: Center(
      child: Container(
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
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                fillColor: Colors.white, // Couleur de fond du TextField
                filled: true,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _pickPDF,
                  child: Text('Sélectionner un PDF'),
                ),
                SizedBox(width: 20), // Espacement entre les boutons
                ElevatedButton(
                  onPressed: _ajouterCours,
                  child: Text('Ajouter Cours'),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_fileName != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.picture_as_pdf, color: Colors.red),
                  SizedBox(width: 10),
                  Text(
                    'Fichier sélectionné: $_fileName',
                    style: TextStyle(fontSize: 16),
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
import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'dart:async';

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

    final String apiUrl = 'http://localhost:9090/compilateur/run-code';
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['nomCoursR'] = _selectedChapter!;
    request.fields['description'] = _descriptionController.text;
    Uint8List pdfBytes = await _convertFileToBytes(_pdfFile!);
    request.files.add(http.MultipartFile.fromBytes('source', pdfBytes, filename: 'file.pdf', contentType: MediaType('application', 'pdf')));

    var response = await request.send();

    if (response.statusCode == 200) {
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
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Échec de l\'ajout du cours'),
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


/* hedha bel url
import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'dart:async';

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

    final String apiUrl = 'http://localhost:9090/compilateur/run-code';
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['nomCoursR'] = _selectedChapter!;
    request.fields['description'] = _descriptionController.text;
    Uint8List pdfBytes = await _convertFileToBytes(_pdfFile!);
    request.files.add(http.MultipartFile.fromBytes('source', pdfBytes, filename: 'file.pdf', contentType: MediaType('application', 'pdf')));

    var response = await request.send();

    if (response.statusCode == 200) {
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
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Échec de l\'ajout du cours'),
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
      appBar: AppBar(
        title: Text('Ajouter Cours'),
        centerTitle: true,
      ),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  Text(
                    'Fichier sélectionné: $_fileName',
                    style: TextStyle(fontSize: 16),
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
*/

/*hlewettttt
import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'dart:async';

class AjoutCoursPage extends StatefulWidget {
  @override
  _AjoutCoursPageState createState() => _AjoutCoursPageState();
}

class _AjoutCoursPageState extends State<AjoutCoursPage> {
  final TextEditingController _descriptionController = TextEditingController();
  html.File? _pdfFile;
  String? _selectedChapter;

  Future<void> _pickPDF() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final userFile = uploadInput.files!.first;
      setState(() {
        _pdfFile = userFile;
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

    final String apiUrl = 'http://localhost:9090/compilateur/run-code';
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['nomCoursR'] = _selectedChapter!;
    request.fields['description'] = _descriptionController.text;
    Uint8List pdfBytes = await _convertFileToBytes(_pdfFile!);
    request.files.add(http.MultipartFile.fromBytes('source', pdfBytes, filename: 'file.pdf', contentType: MediaType('application', 'pdf')));

    var response = await request.send();

    if (response.statusCode == 200) {
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
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Échec de l\'ajout du cours'),
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
      appBar: AppBar(
        title: Text('Ajouter Cours'),
        centerTitle: true,
      ),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
*/

//behyyyyy
/*import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'dart:async';

class AjoutCoursPage extends StatefulWidget {
  @override
  _AjoutCoursPageState createState() => _AjoutCoursPageState();
}

class _AjoutCoursPageState extends State<AjoutCoursPage> {
  final TextEditingController _descriptionController = TextEditingController();
  html.File? _pdfFile;
  String? _selectedChapter;

  Future<void> _pickPDF() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final userFile = uploadInput.files!.first;
      setState(() {
        _pdfFile = userFile;
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner un PDF, choisir un chapitre et entrer une description')),
      );
      return;
    }

    final String apiUrl = 'http://localhost:9090/compilateur/run-code';
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['nomCoursR'] = _selectedChapter!;
    request.fields['description'] = _descriptionController.text;
    Uint8List pdfBytes = await _convertFileToBytes(_pdfFile!);
    request.files.add(http.MultipartFile.fromBytes('source', pdfBytes, filename: 'file.pdf', contentType: MediaType('application', 'pdf')));

    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cours ajouté avec succès')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de l\'ajout du cours')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter Cours'),
        centerTitle: true,
      ),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
*/
/*import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'dart:async';

class AjoutCoursPage extends StatefulWidget {
  @override
  _AjoutCoursPageState createState() => _AjoutCoursPageState();
}

class _AjoutCoursPageState extends State<AjoutCoursPage> {
  final TextEditingController _descriptionController = TextEditingController();
  html.File? _pdfFile;
  String? _selectedChapter; // Variable pour stocker le chapitre sélectionné

  Future<void> _pickPDF() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final userFile = uploadInput.files!.first;
      setState(() {
        _pdfFile = userFile;
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner un PDF, choisir un chapitre et entrer une description')),
      );
      return;
    }

    final String apiUrl = 'http://localhost:9090/compilateur/run-code';

    // Créer une requête multipart
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['nomCoursR'] = _selectedChapter!; // Utiliser le chapitre sélectionné
    request.fields['description'] = _descriptionController.text;
    Uint8List pdfBytes = await _convertFileToBytes(_pdfFile!);
    request.files.add(http.MultipartFile.fromBytes('source', pdfBytes, filename: 'file.pdf', contentType: MediaType('application', 'pdf')));

    // Envoyer la requête
    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cours ajouté avec succès')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de l\'ajout du cours')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter Cours'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickPDF,
              child: Text('Sélectionner un PDF'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _ajouterCours,
              child: Text('Ajouter Cours'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'dart:async';

class AjoutCoursPage extends StatefulWidget {
  @override
  _AjoutCoursPageState createState() => _AjoutCoursPageState();
}

class _AjoutCoursPageState extends State<AjoutCoursPage> {
  final TextEditingController _descriptionController = TextEditingController();
  html.File? _pdfFile;
  String? _selectedChapter;

  Future<void> _pickPDF() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final userFile = uploadInput.files!.first;
      setState(() {
        _pdfFile = userFile;
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner un PDF, choisir un chapitre et entrer une description')),
      );
      return;
    }

    final String apiUrl = 'http://localhost:9090/compilateur/run-code';

    // Créer une requête multipart
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['nomCoursR'] = _selectedChapter!;
    request.fields['description'] = _descriptionController.text; // Ajout de la description à la requête
    Uint8List pdfBytes = await _convertFileToBytes(_pdfFile!);
    request.files.add(http.MultipartFile.fromBytes('source', pdfBytes, filename: 'file.pdf', contentType: MediaType('application', 'pdf')));

    // Envoyer la requête
    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cours ajouté avec succès')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de l\'ajout du cours')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter Cours'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: _selectedChapter,
              hint: Text('Choisir un chapitre'),
              items: <String>["Les classes et les objets", "L'héritage", "le polymorphisme", "Les interfaces", "encapsulation"].map<DropdownMenuItem<String>>((String value) {
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
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickPDF,
              child: Text('Sélectionner un PDF'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _ajouterCours,
              child: Text('Ajouter Cours'),
            ),
          ],
        ),
      ),
    );
  }
}*/

/*hedhi b description
import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'dart:async';

class AjoutCoursPage extends StatefulWidget {
  @override
  _AjoutCoursPageState createState() => _AjoutCoursPageState();
}

class _AjoutCoursPageState extends State<AjoutCoursPage> {
  final TextEditingController _nomCoursController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController(); // Nouveau contrôleur pour la description
  html.File? _pdfFile;

  Future<void> _pickPDF() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final userFile = uploadInput.files!.first;
      setState(() {
        _pdfFile = userFile;
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
    if (_pdfFile == null || _nomCoursController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner un PDF, entrer un nom de cours et une description')),
      );
      return;
    }

    final String apiUrl = 'http://localhost:9090/compilateur/run-code';

    // Créer une requête multipart
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['nomCoursR'] = _nomCoursController.text;
    request.fields['description'] = _descriptionController.text; // Ajout de la description à la requête
    Uint8List pdfBytes = await _convertFileToBytes(_pdfFile!);
    request.files.add(http.MultipartFile.fromBytes('source', pdfBytes, filename: 'file.pdf', contentType: MediaType('application', 'pdf')));

    // Envoyer la requête
    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cours ajouté avec succès')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de l\'ajout du cours')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter Cours'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomCoursController,
              decoration: InputDecoration(labelText: 'Nom du Cours'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickPDF,
              child: Text('Sélectionner un PDF'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _ajouterCours,
              child: Text('Ajouter Cours'),
            ),
          ],
        ),
      ),
    );
  }
}*/
//hedhi lola 
/*import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'dart:async';

class AjoutCoursPage extends StatefulWidget {
  @override
  _AjoutCoursPageState createState() => _AjoutCoursPageState();
}

class _AjoutCoursPageState extends State<AjoutCoursPage> {
  final TextEditingController _nomCoursController = TextEditingController();
  html.File? _pdfFile;

  Future<void> _pickPDF() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final userFile = uploadInput.files!.first;
      setState(() {
        _pdfFile = userFile;
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
    if (_pdfFile == null || _nomCoursController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner un PDF et entrer un nom de cours')),
      );
      return;
    }

    final String apiUrl = 'http://localhost:9090/compilateur/run-code';

    // Créer une requête multipart
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['nomCoursR'] = _nomCoursController.text;
    Uint8List pdfBytes = await _convertFileToBytes(_pdfFile!);
    request.files.add(http.MultipartFile.fromBytes('source', pdfBytes, filename: 'file.pdf', contentType: MediaType('application', 'pdf')));

    // Envoyer la requête
    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cours ajouté avec succès')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de l\'ajout du cours')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter Cours'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomCoursController,
              decoration: InputDecoration(labelText: 'Nom du Cours'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickPDF,
              child: Text('Sélectionner un PDF'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _ajouterCours,
              child: Text('Ajouter Cours'),
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class AjoutCoursPage extends StatefulWidget {
  @override
  _AjoutCoursPageState createState() => _AjoutCoursPageState();
}

class _AjoutCoursPageState extends State<AjoutCoursPage> {
  final TextEditingController _nomCoursController = TextEditingController();
  File? _pdfFile;

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFile = File.fromRawPath(result.files.single.bytes!);
      });
    }
  }

  Future<void> _ajouterCours() async {
    if (_pdfFile == null || _nomCoursController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner un PDF et entrer un nom de cours')),
      );
      return;
    }

    final Uri apiUrl = Uri.parse('http://localhost:9090/compilateur/ajouter-cours');

    final response = await http.post(
      apiUrl,
      body: {
        'nomCoursR': _nomCoursController.text,
      },
    );

    if (response.statusCode == 200) {
      // Uploader le PDF sur le serveur
      final request = http.MultipartRequest('POST', Uri.parse('http://localhost:9090/compilateur/run-code'));
      request.files.add(
        http.MultipartFile.fromBytes(
          'source',
          _pdfFile!.readAsBytesSync(),
          filename: _pdfFile!.path.split('/').last,
        ),
      );
      final uploadedResponse = await request.send();

      if (uploadedResponse.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cours ajouté avec succès')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de l\'ajout du cours')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de l\'ajout du cours')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter Cours'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomCoursController,
              decoration: InputDecoration(labelText: 'Nom du Cours'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickPDF,
              child: Text('Sélectionner un PDF'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _ajouterCours,
              child: Text('Ajouter Cours'),
            ),
          ],
        ),
      ),
    );
  }
}*/

/*import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class AjoutCoursPage extends StatefulWidget {
  @override
  _AjoutCoursPageState createState() => _AjoutCoursPageState();
}

class _AjoutCoursPageState extends State<AjoutCoursPage> {
  final TextEditingController _nomCoursController = TextEditingController();
  File? _pdfFile;

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _ajouterCours() async {
    if (_pdfFile == null || _nomCoursController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner un PDF et entrer un nom de cours')),
      );
      return;
    }

    final Uri apiUrl = Uri.parse('http://localhost:9090/compilateur/run-code');

    final response = await http.post(
      apiUrl,
      body: {
        'nomCoursR': _nomCoursController.text,
      },
    );

    if (response.statusCode == 200) {
      // Uploader le PDF sur le serveur
      final request = http.MultipartRequest('POST', Uri.parse('http://localhost:9090/compilateur/upload-pdf'));
      request.files.add(
        http.MultipartFile(
          'pdf',
          _pdfFile!.readAsBytes().asStream(),
          _pdfFile!.lengthSync(),
          filename: _pdfFile!.path.split('/').last,
        ),
      );
      final uploadedResponse = await request.send();

      if (uploadedResponse.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cours ajouté avec succès')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de l\'ajout du cours')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de l\'ajout du cours')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter Cours'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomCoursController,
              decoration: InputDecoration(labelText: 'Nom du Cours'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickPDF,
              child: Text('Sélectionner un PDF'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _ajouterCours,
              child: Text('Ajouter Cours'),
            ),
          ],
        ),
      ),
    );
  }
}*/
