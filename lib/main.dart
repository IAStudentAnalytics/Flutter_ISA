import 'package:flutter/material.dart';
import 'package:performance/Studenthome.dart';
import 'package:performance/performance.dart';
import 'package:performance/quiz.dart';
import 'package:performance/qa.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
       
      },
    );
  }
}
