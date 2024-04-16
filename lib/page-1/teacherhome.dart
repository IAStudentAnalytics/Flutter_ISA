import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'side_menu.dart';  // Ensure 'side_menu.dart' contains the necessary widget definition


class Sceneteacherhome extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
  future: _getUserDataFromSharedPreferences(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasData && snapshot.data != null) {
      var userData = json.decode(snapshot.data!);
      String userName = (userData['user'] != null && userData['user']['firstName'] != null) ? userData['user']['firstName'] : 'Guest';
          final double screenWidth = MediaQuery.of(context).size.width;
          final double screenHeight = MediaQuery.of(context).size.height;
          final double fem = screenWidth / 411;

          return Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    width: screenWidth,
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
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xffdf0b0b), Color(0x00f6f1fb)],
                          stops: [0, 1],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20 * fem),
                          Padding(
                            padding: EdgeInsets.all(16 * fem),
                            child: Text(
                              "Welcome, $userName!",
                              style: TextStyle(
                                fontSize: 24 * fem,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16 * fem),
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 10 * fem,
                              mainAxisSpacing: 10 * fem,
                              childAspectRatio: (2 / 1),
                              children: <Widget>[
                                buildMenuButton(context, fem, 'Create Test', Icons.question_answer, '/create_test'),
                                buildMenuButton(context, fem, 'List of Students', Icons.people, '/list_students'),
                                buildMenuButton(context, fem, 'Tests History', Icons.history, '/tests_history'),
                              ],
                            ),
                          ),
                          SizedBox(height: 10 * fem),
                          buildStatSection(context, screenWidth, fem),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            drawer: SideMenu(onMenuItemClicked: (int ) {  },),  // Custom widget for the drawer
          );
        } else {
          return Scaffold(
            body: Center(child: Text("Please login again, no user data available.")),
          );
        }
      },
    );
  }

  Widget buildMenuButton(BuildContext context, double fem, String text, IconData icon, String route) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 20 * fem),
        title: Text(text, style: TextStyle(fontSize: 14 * fem)),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }

  Widget buildStatSection(BuildContext context, double screenWidth, double fem) {
    return Container(
      padding: EdgeInsets.all(16 * fem),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildStatBubble(context, 'Chapter', '85%', Colors.blue, ['Choice 1', 'Choice 2', 'Choice 3']),
          buildStatBubble(context, 'Test', '92%', Colors.green, ['Choice 1', 'Choice 2', 'Choice 3']),
        ],
      ),
    );
  }

  Widget buildStatBubble(BuildContext context, String title, String percentage, Color color, List<String> choices) {
    double fem = MediaQuery.of(context).size.width / 411;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 200,
              color: Color(0xFF737373),  // Could adjust this as needed for your design
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(title + " " + percentage, style: TextStyle(fontSize: 24 * fem, color: color)),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: 70 * fem,
        height: 70 * fem,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
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
          child: Text(
            percentage,
            style: TextStyle(
              fontSize: 14 * fem,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }


  Future<String?> _getUserDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    print("Retrieved User Data: $userData");  // Additional debugging
    return userData;
  }
}
