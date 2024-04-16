import 'package:flutter/material.dart';



class QAPage extends StatelessWidget {
  const QAPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: const [
            Quiz(),
          ],
        ),
      ),
    );
  }
}

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Color buttonColor = Colors.white;
 Map<String, Color> buttonColors = {}; // Stocker les couleurs des boutons

  Widget _buildChoiceButton(
      BuildContext context, String choice, bool isCorrect) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          onPrimary: Colors.black, // Changez la couleur du texte si nécessaire
          textStyle: const TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () {
          
          // Ajoutez ici ce qui se passe lorsque le bouton est appuyé
        },
        child: Text(choice),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 411,
          height: 869,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: const Color(0xFFF4F2F6)),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: -3,
                child: Container(
                  width: 411,
                  height: 872,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 411,
                          height: 872,
                          decoration:  ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0xFFDF0B0B), Color(0x00F6F1FB)],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 411,
                          height: 108.27,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0xFFDF0B0B), Color(0x00F6F1FB)],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 49,
                top: 46,
                child: Container(
                  width: 262,
                  height: 248,
                  decoration: const ShapeDecoration(
                    color: Color(0x5BFB7D54),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 78,
                top: 72,
                child: Container(
                  width: 204,
                  height: 196,
                  decoration: const ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFFE96868), Color(0x00FCA8A8)],
                    ),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 104,
                top: 98,
                child: ClipOval(
                  child: Container(
                    width: 152,
                    height: 144,
                    color: Colors.white,
                    child: Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          'assets/quizz.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 285,
                top: 25,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: const ShapeDecoration(
                    color: Color(0x5BFB7D54),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 6,
                top: 8,
                child: Container(
                  width: 129,
                  height: 117,
                  decoration: const ShapeDecoration(
                    color: Color(0x5BFB7D54),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 300,
                child: Container(
                  width: 316,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F9D57E3),
                        blurRadius: 13,
                        offset: Offset(0, 2),
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Votre énoncé de quiz ici. Ajustez le texte selon le contenu de votre quiz.",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 400,
                child: SizedBox(
                  width: 316,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildChoiceButton(context, 'Choice 1', false),
                      _buildChoiceButton(context, 'Choice 2', true),
                      _buildChoiceButton(context, 'Choice 3', false),
                      _buildChoiceButton(context, 'Choice 4', false),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}