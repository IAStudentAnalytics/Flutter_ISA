import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompilerPage extends StatefulWidget {
  @override
  _CompilerPageState createState() => _CompilerPageState();
}

class _CompilerPageState extends State<CompilerPage> {
  late TextEditingController _codeController;
  String _output = '';

  @override
  void initState() {
    super.initState();

    _codeController = TextEditingController(
      text: '''
public class HelloWorld {
  public static void main(String[] args) {
    System.out.println("Hello World");
  }
}
''',
    );
  }

  Future<void> _runCode() async {
    final String code = _codeController.text;

    try {
      final response = await http.post(
        Uri.parse('http://localhost:9090/compilateur/run-code'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'script': code,
        }),
      );

      final data = jsonDecode(response.body);
      setState(() {
        _output = data['output'];
      });
    } catch (error) {
      print('Erreur lors de l\'exécution du code : $error');
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
              Color.fromRGBO(193, 143, 143, 1),
              const Color.fromARGB(255, 255, 255, 255)
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'EduSwift Compilator Java',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 39, 33, 33),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _runCode,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.play_arrow, color: Colors.white),
                      Text(
                        'Run',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _codeController,
                maxLines: 15,
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Container(
                  width: double
                      .infinity, 
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(201, 237, 235, 235), 
                    border: Border.all(color: Color.fromARGB(185, 0, 0, 0)),
                  ),
                  child: Text(
                    _output,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
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
