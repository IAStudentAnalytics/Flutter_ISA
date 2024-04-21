import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart'; // Importer le package fl_chart
import 'side_menu.dart'; // Import the side_menu.dart file
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // pour utiliser json.decode

class TestInfo {
  final String? id;
  final String? title;
  final String? description;
  final DateTime? date;
  final List<String>? chapters;

  const TestInfo({
    this.id,
    this.title,
    this.description,
    this.date,
    this.chapters,
  });

  // Le constructeur nommé 'fromJson' pour créer une instance à partir de JSON
 factory TestInfo.fromJson(Map<String, dynamic> json) {
  return TestInfo(
    id: json['_id'] as String? ?? '', // Note: Using '_id' from your JSON response
    title: json['title'] as String? ?? '',
    description: json['description'] as String? ?? '',
    date: json['testDate'] == null ? null : DateTime.parse(json['testDate'] as String),
    chapters: [], // Based on your JSON, it looks like chapters might not be included
  );
}

  }


Future<List<TestInfo>> getAllTests() async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:63148/test/getAllTests'));
    print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    List<dynamic> testsJson = json.decode(response.body);
    return testsJson.map((json) => TestInfo.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load tests');
  }
}

Future<List<String>> getChaptersByTestId(String testId) async {
  final response = await http
      .get(Uri.parse('http://10.0.2.2:63148/test/tests/$testId/chapters'));

  if (response.statusCode == 200) {
    List<dynamic> chaptersJson = json.decode(response.body);
    return List<String>.from(chaptersJson);
  } else {
    throw Exception('Failed to load chapters');
  }
}

class SceneStudentHome extends StatelessWidget {
  final String email;

  // Constructeur pour recevoir l'e-mail de l'utilisateur
  const SceneStudentHome({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fem = screenWidth / 411;
    String userName = email.split('@')[0]; // Extract user name from email

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
                    colors: [Color(0xffdf0b0b), Color(0x00f6f1fb)],
                    stops: [0, 1],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 25 * fem),
                    Text(
                      "Welcome, $userName",
                      style: TextStyle(
                        fontSize: 25 * fem,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<List<TestInfo>>(
                        future: getAllTests(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return buildTestButton(
                                    context, snapshot.data![index], fem);
                              },
                            );
                          } else {
                            return Text('No tests found');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget buildTestButton(BuildContext context, TestInfo test, double fem) {
  // Vérifiez si la date du test est aujourd'hui.
  bool isToday = test.date != null && 
                 DateTime.now().year == test.date!.year &&
                 DateTime.now().month == test.date!.month &&
                 DateTime.now().day == test.date!.day;

  return Container(
    margin: EdgeInsets.only(bottom: 10),
    child: ElevatedButton(
      onPressed: isToday ? () {
        // Logique pour ce qui se passe lorsque le bouton est pressé.
      } : null, // Si la date n'est pas aujourd'hui, le bouton est désactivé.
      child: Text(
        "${test.description}\nDate: ${test.date != null ? DateFormat('yyyy-MM-dd').format(test.date!) : 'No date provided'}\n",
      ),
      style: ElevatedButton.styleFrom(
        primary: isToday ? Colors.blue : Colors.grey, // Bleu si la date est aujourd'hui, sinon gris.
        onPrimary: Colors.white,
        textStyle: TextStyle(fontSize: 16 * fem),
        padding: EdgeInsets.symmetric(horizontal: 30 * fem, vertical: 20 * fem),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5 * fem),
        ),
      ),
    ),
  );
}


}
