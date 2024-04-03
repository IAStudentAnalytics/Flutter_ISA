import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart'; // Importer le package fl_chart
import 'side_menu.dart'; // Import the side_menu.dart file

class Sceneteacherhome extends StatelessWidget {
  final String email;

  // Constructeur pour recevoir l'e-mail de l'utilisateur
  const Sceneteacherhome({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fem = screenWidth / 411;

    // Extraire le nom de l'e-mail
    String userName = email.split('@')[0]; // Supprimer le domaine de l'e-mail

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight,
              decoration: BoxDecoration(
                color: Color(0xfff4f2f6),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight,
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
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 16 * fem),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10 * fem),
                                  child: Builder(
                                    builder: (context) => TextButton(
                                      onPressed: () {
                                        Scaffold.of(context).openDrawer();
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
                                  margin: EdgeInsets.only(right: 10 * fem),
                                  child:  Text(
                                  userName,
                                  style: TextStyle(
                                    fontSize: 25 * fem,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 241, 242, 243),
                                  ),
                                ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25 * fem),
Column(
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildMenuButton(context, fem, 'Create Test', Icons.question_answer, '/create_test'),
        buildMenuButton(context, fem, 'List of Students', Icons.people, '/list_students'),
      ],
    ),
    SizedBox(height: 20 * fem), // Ajoutez un espacement entre les deux rangées
    Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centrez horizontalement les boutons
      children: [
        buildMenuButton(context, fem, 'Tests History', Icons.history, '/tests_history'),
      ],
    ),
  ],
),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10 * fem,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildStatBubble(context, 'Chapter', '85%', Colors.blue, ['Choice 1', 'Choice 2', 'Choice 3']),
                  buildStatBubble(context, 'Test', '92%', Colors.green, ['Choice 1', 'Choice 2', 'Choice 3']),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: SideMenu(onMenuItemClicked: (int) {}),
    );
  }

  Widget buildMenuButton(BuildContext context, double fem, String text, IconData icon, String route) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16.0 * fem, vertical: 12.0 * fem),
        minimumSize: Size(150 * fem, 50 * fem),
      ),
    );
  }

  Widget buildStatBubble(BuildContext context, String title, String percentage, Color color, List<String> choices) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fem = screenWidth / 411;
    return GestureDetector(
      onTap: () {
        // Handle tap on bubble
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18 * fem),
          ),
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                Positioned(
                  bottom: 20 * fem,
                  left: 0,
                  right: 0,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: 180 * fem,
                    height: 180 * fem,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10 * fem,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10 * fem),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 20 * fem,
                                    fontWeight: FontWeight.bold,
                                    color: color,
                                  ),
                                ),
                                SizedBox(height: 5 * fem),
                                Text(
                                  percentage,
                                  style: TextStyle(
                                    fontSize: 18 * fem,
                                    fontWeight: FontWeight.bold,
                                    color: color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40 * fem,
                          left: 0,
                          right: 0,
                          child: PieChart(
                            PieChartData(
                              sections: List.generate(
                                5,
                                (index) {
                                  return PieChartSectionData(
                                    value: 20,
                                    color: color,
                                    title: 'Chapter ${index + 1}',
                                    radius: 50 * fem,
                                    titleStyle: TextStyle(
                                      fontSize: 12 * fem,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10 * fem,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              choices.length,
                              (index) {
                                double angle = index * (math.pi / (choices.length - 1)) - (math.pi / 2);
                                double xOffset = 70 * fem * math.cos(angle);
                                double yOffset = 70 * fem * math.sin(angle);
                                return Container(
                                  margin: EdgeInsets.only(right: 5 * fem),
                                  transform: Matrix4.translationValues(xOffset, yOffset, 0.0),
                                  child: Container(
                                    padding: EdgeInsets.all(5 * fem),
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(8 * fem),
                                    ),
                                    child: Text(
                                      choices[index],
                                      style: TextStyle(
                                        fontSize: 12 * fem,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: 70 * fem,
        height: 70 * fem,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 10 * fem,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 5 * fem),
              Text(
                percentage,
                style: TextStyle(
                  fontSize: 14 * fem,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
