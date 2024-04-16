import 'package:flutter/material.dart';
import 'package:performance/Studenthome.dart';
import 'package:performance/qa.dart';
import 'package:performance/quiz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',  // Définition de la route initiale
      routes: {
        '/': (context) => const SceneStudentHome(email: 'example@email.com'), // Route initiale
        '/qa': (context) => const QAPage(), // Assurez-vous que QAPage est un widget existant
        '/quiz': (context) => const QuizPage(), // Assurez-vous que QuizPage est un widget existant
        // Vous pouvez ajouter d'autres routes si nécessaire
      },
    );
  }
}
