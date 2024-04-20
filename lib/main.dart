import 'package:flutter/material.dart';
import 'package:pim/page-1/compilateur.dart';



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
           children: [ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CompilerPage()),
            );
          },
          child: Text('Go to Compiler Page'),
        ),
        
          ],
        ),
      ), 
    );
  }
}