import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'side_menu.dart';  // Ensure 'side_menu.dart' contains the necessary widget definitions
import 'package:fl_chart/fl_chart.dart';

class Sceneteacherhome extends StatelessWidget {
  Future<Map<String, dynamic>?> _getUserDataFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      return json.decode(userDataString);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _getUserDataFromSharedPreferences(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          var userData = snapshot.data;
          String userName = (userData != null && userData['user'] != null && userData['user']['firstName'] != null) ? userData['user']['firstName'] : 'Guest';
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
            drawer: SideMenu(onMenuItemClicked: (int) {  }),  // Custom widget for the drawer
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
      width: screenWidth,
      padding: EdgeInsets.all(16 * fem),
      child: BarChart(BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        barGroups: [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(y: 80, colors: [Colors.lightBlue])], showingTooltipIndicators: [0]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(y: 65, colors: [Colors.orange])], showingTooltipIndicators: [0]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(y: 95, colors: [Colors.red])], showingTooltipIndicators: [0]),
          BarChartGroupData(x: 3, barRods: [BarChartRodData(y: 90, colors: [Colors.green])], showingTooltipIndicators: [0]),
          BarChartGroupData(x: 4, barRods: [BarChartRodData(y: 75, colors: [Colors.yellow])], showingTooltipIndicators: [0]),
        ],
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'Classes & Objects';
                case 1:
                  return 'Heritage';
                case 2:
                  return 'Polymorphism';
                case 3:
                  return 'Interfaces';
                case 4:
                  return 'Encapsulation';
                default:
                  return '';
              }
            },
            margin: 8,
          ),
          leftTitles: SideTitles(showTitles: false),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
      )),
    );
  }
}
