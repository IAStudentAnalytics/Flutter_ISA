import 'package:flutter/material.dart';
import 'side_menu.dart'; // Importez le fichier side_menu.dart

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fem = screenWidth / 411;
    double ffem = fem * 0.97;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/quiz.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18 * fem),
                    gradient: LinearGradient(
                      begin: Alignment(0, -1),
                      end: Alignment(0, 1),
                      colors: <Color>[Color(0xffdf0b0b), Color(0x00f6f1fb)],
                      stops: <double>[0, 1],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0 * fem),
                        child: Text(
                          'Question: Quelle est la capitale de la France?',
                          style: TextStyle(
                            fontSize: 24.0 * fem,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0 * fem),
                      buildChoiceButton('Paris', context),
                      buildChoiceButton('Londres', context),
                      buildChoiceButton('Berlin', context),
                      buildChoiceButton('Madrid', context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: SideMenu(onMenuItemClicked: (int) {}),
    );
  }

  Widget buildChoiceButton(String choice, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fem = screenWidth / 411;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0 * fem, vertical: 10.0 * fem),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Réponse'),
              content: Text(choice == 'Paris'
                  ? 'Bonne réponse!'
                  : 'Mauvaise réponse! La capitale de la France est Paris.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 15.0 * fem),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0 * fem),
          ),
        ),
        child: Text(
          choice,
          style: TextStyle(fontSize: 18.0 * fem),
        ),
      ),
    );
  }
}
