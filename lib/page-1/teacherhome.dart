import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'side_menu.dart';
import 'package:fl_chart/fl_chart.dart';

class Sceneteacherhome extends StatefulWidget {
  @override
  _SceneteacherhomeState createState() => _SceneteacherhomeState();
}

class _SceneteacherhomeState extends State<Sceneteacherhome> {
  Map<String, dynamic>? userData;

  Future<void> _getUserDataFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      setState(() {
        userData = json.decode(userDataString);
      });
    }
  }

  Future<Map<String, dynamic>> _getAllScoresByChapter() async {
    final apiUrl = 'http://192.168.1.19:5000/note/all-scores';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load score data or data is empty');
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserDataFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double fem = screenWidth / 411;

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: screenHeight),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Container(
                  width: screenWidth,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.menu, color: Colors.white),
                                      onPressed: () {
                                        // Open the side menu
                                        Scaffold.of(context).openDrawer();
                                      },
                                    ),
                                    Text(
                                      "Welcome, ${userData != null && userData!['user'] != null && userData!['user']['firstName'] != null ? userData!['user']['firstName'] : 'Guest'}!",
                                      style: TextStyle(
                                        fontSize: 24 * fem,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 40), // Placeholder for the menu icon
                                  ],
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
                              Expanded(
                                child: FutureBuilder<Map<String, dynamic>>(
                                  future: _getAllScoresByChapter(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (snapshot.hasData && snapshot.data != null) {
                                      Map<String, dynamic> scores = snapshot.data!;
                                      return buildStatSection(context, scores, fem);
                                    } else {
                                      return Text('No data available');
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 20 * fem),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: SideMenu(onMenuItemClicked: (int) {}),
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

  Widget buildStatSection(BuildContext context, Map<String, dynamic> scores, double fem) {
    List<PieChartSectionData> sections = [];
    int index = 0;
    List<Color> colors = [Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.purple]; // Example colors

    scores.forEach((key, value) {
      sections.add(PieChartSectionData(
        color: colors[index % colors.length],
        value: value.toDouble(),
        title: '$key\n${value.toStringAsFixed(1)}%',
        radius: 100,
        titlePositionPercentageOffset: 0.55,
        titleStyle: TextStyle(
          fontSize: 14 * fem,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          backgroundColor: colors[index % colors.length]
        ),
      ));
      index++;
    });

    return Padding(
      padding: EdgeInsets.all(16 * fem),
      child: PieChart(
        PieChartData(
          sections: sections,
          centerSpaceRadius: 60,
          sectionsSpace: 0,
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, PieTouchResponse? response) {
              // Here you can handle the touch event
              if (response != null && response.touchedSection != null) {
                print("Touched section index: ${response.touchedSection!.touchedSectionIndex}");
              }
            },
          ),
        ),
      ),
    );
  }
}
