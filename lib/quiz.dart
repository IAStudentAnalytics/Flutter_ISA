import 'package:flutter/material.dart';



class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            ResultQuiz(),
          ],
        ),
      ),
    );
  }
}

class ResultQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 411,
          height: 869,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFF4F2F6)),
          child: Stack(
            children: [
              Positioned(
                left: -37,
                top: -80,
                child: Container(
                  width: 573,
                  height: 961,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 37,
                        top: 80,
                        child: Container(
                          width: 411,
                          height: 881,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 411,
                                  height: 881,
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.00, -1.00),
                                      end: Alignment(0, 1),
                                      colors: [
                                        Color(0xFFFABFBF),
                                        Color(0x00FBF5F5)
                                      ],
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
                                  height: 56,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.00, -1.00),
                                      end: Alignment(0, 1),
                                      colors: [
                                        Color(0xFFFABFBF),
                                        Color(0x00FBF5F5)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 97,
                        child: Container(
                          width: 262,
                          height: 248,
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0xFFDA3838), Color(0x00C7A8FC)],
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 29,
                        top: 123,
                        child: Container(
                          width: 204,
                          height: 196,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF8A4A4),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 318,
                        top: 169,
                        child: Container(
                          width: 255,
                          height: 240,
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0xFFDA3838), Color(0x00C7A8FC)],
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 283,
                        top: 144,
                        child: Container(
                          width: 52,
                          height: 52,
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0xFFDA3838), Color(0x00C7A8FC)],
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 172,
                        top: 0,
                        child: Container(
                          width: 129,
                          height: 117,
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0xFFDA3838), Color(0x00C7A8FC)],
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: -65,
                top: 292,
                child: Container(
                  width: 129,
                  height: 117,
                  decoration: ShapeDecoration(
                    color: Color(0x5BC7A8FC),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 324,
                top: 364,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: ShapeDecoration(
                    color: Color(0x5BC7A8FC),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 80,
                top: 500,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/result.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 90,
                top: 200,
                child: Container(
                  padding: EdgeInsets.all(
                      8), // Ajouter un espacement autour de l'image et du texte
                  decoration: BoxDecoration(
                    color: Colors.white, // Couleur de fond blanche du conteneur
                    borderRadius: BorderRadius.circular(
                        10), // Coins arrondis du conteneur
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Opacity(
                          opacity: 0.5,
                          child: Image.asset(
                            'assets/iconr.png', // Chemin de votre image
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                          width:
                              8), // Ajouter un espace horizontal entre l'image et le texte
                      Text(
                        'Très bien 20/20',
                        style: TextStyle(
                          color: Colors.black, // Couleur du texte
                          fontSize: 16, // Taille de la police
                          fontWeight: FontWeight.bold, // Poids de la police
                        ),
                      ),
                      SizedBox(
                          height:
                              16), // Ajouter un espacement entre le texte et le bouton
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Gérer le retour à l'accueil ici
                              print('Retour à l\'accueil');
                            },
                            child: Text('Retour à l\'accueil'),
                          ),
                        ],
                      ),
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
