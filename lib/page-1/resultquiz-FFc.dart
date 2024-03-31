import 'package:flutter/material.dart';

class ResultQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.8;
    double screenHeight = MediaQuery.of(context).size.height * 0.8;

    return Scaffold(
      body: Center(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFF4F2F6)),
          child: Stack(
            children: [
              Positioned(
                left: -37 * screenWidth / 411,
                top: -80 * screenHeight / 881,
                child: Container(
                  width: 573 * screenWidth / 411,
                  height: 961 * screenHeight / 881,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 37 * screenWidth / 411,
                        top: 80 * screenHeight / 881,
                        child: Container(
                          width: 411 * screenWidth / 411,
                          height: 881 * screenHeight / 881,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0 * screenWidth / 411,
                                top: 0 * screenHeight / 881,
                                child: Container(
                                  width: 411 * screenWidth / 411,
                                  height: 881 * screenHeight / 881,
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
                                left: 0 * screenWidth / 411,
                                top: 0 * screenHeight / 881,
                                child: Container(
                                  width: 411 * screenWidth / 411,
                                  height: 56 * screenHeight / 881,
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
                      // Ajoutez les autres éléments ici
                    ],
                  ),
                ),
              ),
              Positioned(
                left: -65 * screenWidth / 411,
                top: 292 * screenHeight / 881,
                child: Container(
                  width: 129 * screenWidth / 411,
                  height: 117 * screenHeight / 881,
                  decoration: ShapeDecoration(
                    color: Color(0x5BC7A8FC),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 324 * screenWidth / 411,
                top: 364 * screenHeight / 881,
                child: Container(
                  width: 110 * screenWidth / 411,
                  height: 110 * screenHeight / 881,
                  decoration: ShapeDecoration(
                    color: Color(0x5BC7A8FC),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 80 * screenWidth / 411,
                top: 500 * screenHeight / 881,
                child: Container(
                  width: 300 * screenWidth / 411,
                  height: 300 * screenHeight / 881,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/result.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 90 * screenWidth / 411,
                top: 200 * screenHeight / 881,
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
                            width: 100 * screenWidth / 411,
                            height: 100 * screenHeight / 881,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                          width:
                              8 * screenWidth / 411), // Ajouter un espace horizontal entre l'image et le texte
                      Text(
                        'Très bien 20/20',
                        style: TextStyle(
                          color: Colors.black, // Couleur du texte
                          fontSize: 16 * screenWidth / 411, // Taille de la police
                          fontWeight: FontWeight.bold, // Poids de la police
                        ),
                      ),
                      SizedBox(
                          height:
                              16 * screenHeight / 881), // Ajouter un espacement entre le texte et le bouton
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
      ),
    );
  }
}
