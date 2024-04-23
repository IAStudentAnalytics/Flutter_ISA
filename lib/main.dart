
import 'package:flutter/material.dart';
import 'package:pim/page-1/coursPage.dart';
import 'package:pim/page-1/ajoutCoursPage.dart';
import 'package:pim/page-1/compilateur.dart';
import 'package:pim/page-1/recommandation.dart';
import 'package:pim/page-1/testblanc.dart';

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
                  MaterialPageRoute(builder: (context) => AjoutCoursPage()),
                );
                // Naviguer vers la page de cours
              },
              child: Text('Ajouter Cours'),
            ),
                        SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Recomandation()),
                );
                // Naviguer vers la page de cours
              },
              child: Text('Recomandation'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CoursPage()),
                );
                // Naviguer vers la page de cours
              },
              child: Text('Cours'),
            ),
          ],
        ),
      ), 
    );
  }
}
