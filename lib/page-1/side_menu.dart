import 'package:flutter/material.dart';
import 'package:pim/page-1/CalendarScreen.dart';
import 'package:pim/page-1/compilateur.dart';
import 'package:pim/page-1/login.dart';
import 'package:pim/page-1/quizzteacher.dart';
import 'package:pim/page-1/rec.dart';
import 'package:pim/page-1/resultatQuiz.dart';

import 'package:pim/page-1/teacherhome.dart';
import 'package:pim/page-1/javabot.dart';
import 'package:pim/page-1/performance.dart';
import 'package:pim/page-1/testblanc.dart';
import 'package:pim/page-1/coursPage.dart';
import 'package:pim/page-1/profile_page.dart';
import 'package:pim/page-1/ajoutCoursPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '/main.dart';

class SideMenu extends StatelessWidget {
  final Function(int) onMenuItemClicked;

  const SideMenu({Key? key, required this.onMenuItemClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildProfileHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  context,
                  'Home',
                  Icons.home,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Sceneteacherhome()),
                  ),
                ),
                _buildMenuItem(
                  context,
                  'Java Bot',
                  Icons.android,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JavaBotPage()),
                  ),
                ),
                _buildMenuItem(
                  context,
                  'Test',
                  Icons.question_answer,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Scenequizzteacher()),
                  ),
                ),
           
                _buildMenuItem(
                  context,
                  'Java Compiler',
                  Icons.code,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompilerPage()),
                  ),
                ),
                _buildMenuItem(
                  context,
                  'Performance!',
                  Icons.show_chart,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Performance(studentId: '65defb8f796124616d1ecdc2')),
                  ),
                ),
                _buildMenuItem(
                  context,
                  'Add Course',
                  Icons.recommend,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AjoutCoursPage()),
                  ),
                ),
                _buildMenuItem(
                  context,
                  'List of courses',
                  Icons.book,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CoursPage()),
                  ),
                ),
                _buildMenuItem(
                  context,
                  'Review space',
                  Icons.description,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TestBlanc()),
                  ),
                ),
                _buildMenuItem(
                  context,
                  'Recommandation',
                  Icons.description,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecommendedVideosPage()),
                  ),
                ),
                _buildMenuItem(
                  context,
                  'Logout',
                  Icons.logout,
                  () => logout(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _getUserDataFromSharedPreferences(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError || !snapshot.hasData) {
          return Text('Error fetching user data');
        } else {
          final userData = snapshot.data;
          final userName = userData?['user']?['firstName'] ?? 'Guest';
          final userEmail = userData?['user']?['email'] ?? 'user@example.com';
          return UserAccountsDrawerHeader(
            accountName: Text("Welcome, $userName!"),
            accountEmail: Text(userEmail),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(113, 236, 131, 131),
                  Color.fromARGB(255, 124, 23, 16)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            onDetailsPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          );
        }
      },
    );
  }

  Future<Map<String, dynamic>> _getUserDataFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      return json.decode(userDataString);
    }
    return {};
  }

  Widget _buildMenuItem(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: onTap,
    );
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Scene1()),
      (Route<dynamic> route) => false,
    );
  }
}
