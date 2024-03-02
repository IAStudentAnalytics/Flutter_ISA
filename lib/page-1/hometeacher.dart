import 'package:flutter/material.dart';
import 'side_menu.dart'; // Importez le fichier side_menu.dart

class Sceneteacherhome extends StatelessWidget {
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
            color: Color(0xfff4f2f6),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: screenWidth, // Utilisation d'un pourcentage de la largeur de l'écran
                  height: screenHeight, // Utilisation d'un pourcentage de la hauteur de l'écran
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: screenHeight * 0.12, // Utilisation d'un pourcentage de la hauteur de l'écran
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0, -1),
                            end: Alignment(0, 1),
                            colors: <Color>[Color(0xffdf0b0b), Color(0x00f6f1fb)],
                            stops: <double>[0, 1],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(3 * fem, 27.67 * fem, 3 * fem, 134 * fem),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 16 * fem), // Espacement dynamique
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10 * fem), // Espacement dynamique
                                     child: Builder(
    builder: (context) => TextButton(
      onPressed: () {
        Scaffold.of(context).openDrawer(); // Ouvrir le menu latéral lors du clic sur le bouton
      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Container(
                                        width: 42 * fem,
                                        height: 45 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/auto-group-sowc.png',
                                          width: 42 * fem,
                                          height: 45 * fem,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10 * fem), // Espacement dynamique
                                    child: Text(
                                      '👋',
                                      style: TextStyle(
                                        fontSize: 19.7266578674 * ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.185 * ffem / fem,
                                        color: Color(0xff0c1e33),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildChapterButton(fem, 'Chapter 1'),
                                  buildChapterButton(fem, 'Chapter 2'),
                                  buildChapterButton(fem, 'Chapter 3'),
                                  buildChapterButton(fem, 'Chapter 4'),
                                  buildChapterButton(fem, 'Chapter 5'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 20 * fem,
                child: Align(
                  child: SizedBox(
                    width: 103 * fem,
                    height: 81 * fem,
                    child: Image.asset(
                      'assets/page-1/images/n-removebg-preview-5.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: SideMenu(onMenuItemClicked: (int ) {  },), // Utilisez le widget SideMenu dans le drawer
    );
  }

  Widget buildChapterButton(double fem, String text, {double buttonHeight = 50.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 26.0 * fem), // Ajouter un padding vertical
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16.0 * fem), // Ajouter un padding horizontal
          minimumSize: Size(double.infinity, buttonHeight * fem), // Ajuster la hauteur du bouton
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 14.0 * fem),
        ),
      ),
    );
  }
}
