import 'package:flutter/material.dart';
import 'package:pim/page-1/CreateTestPage.dart';
import 'side_menu.dart'; // Import the side_menu.dart file

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
                  width: screenWidth, // Use a percentage of the screen width
                  height: screenHeight, // Use a percentage of the screen height
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
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 16 * fem), // Dynamic spacing
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10 * fem), // Dynamic spacing
                                    child: Builder(
                                      builder: (context) => TextButton(
                                        onPressed: () {
                                          Scaffold.of(context).openDrawer(); // Open the side menu when the button is clicked
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
                                    margin: EdgeInsets.only(right: 10 * fem), // Dynamic spacing
                                    child: Text(
                                      '👋',
                                      style: TextStyle(
                                        fontSize: 19.7266578674 * ffem,
                                        fontWeight: FontWeight.w700,
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
                            SizedBox(height: 20 * fem), // Add some space between the search field and the buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildMenuButton(context, fem, 'Create Test', Icons.question_answer, '/create_test'),
                              ],
                            ),
                            SizedBox(height: 20 * fem), // Add some space between the button rows
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildMenuButton(context, fem, 'List of Students', Icons.people, ''),
                                buildMenuButton(context, fem, 'Tests History', Icons.history, ''),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: 0.15,
                  child: Align(
                    alignment: Alignment.center,
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      heightFactor: 0.5,
                      child: Image.asset(
                        'assets/page-1/images/n-removebg-preview-5.png',
                        fit: BoxFit.cover, // Adjust how the image should be fitted
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: SideMenu(onMenuItemClicked: (int) {}), // Use the SideMenu widget in the drawer
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
        // Adjust button size according to screen size
        minimumSize: Size(150 * fem, 50 * fem),
      ),
    );
  }
}
