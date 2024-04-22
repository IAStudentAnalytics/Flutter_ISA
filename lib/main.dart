import 'package:flutter/material.dart';
import 'package:pim/page-1/compilateur.dart';
import 'package:pim/page-1/testblanc.dart';
import 'package:pim/page-1/rec.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduSwift',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompilerPage()),
                );
              },
              child: Text('Go to Compiler Page'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TestBlanc()),
                );
              },
              child: Text('Go to Quiz Page'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecommendedVideosPage()),
                );
              },
              child: Text('Go to Quiz Rec'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
