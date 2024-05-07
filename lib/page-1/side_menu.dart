import 'package:flutter/material.dart';
import 'package:pim/page-1/teacherhome.dart';
import 'package:pim/page-1/javabot.dart';
import 'package:pim/page-1/compilateur.dart';
import 'package:pim/page-1/performance.dart';
import 'package:pim/page-1/ajoutCoursPage.dart';
import 'package:pim/page-1/coursPage.dart';
import 'package:pim/page-1/testblanc.dart';
import 'package:pim/page-1/login.dart';
import 'package:pim/page-1/Studenthome.dart';
import 'package:pim/page-1/Profile_page.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key, required Null Function(dynamic int) onMenuItemClicked}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late List<Widget> menuItems;

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  Future<void> _loadMenuItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      final userData = json.decode(userDataString);
      String role = userData['message'].contains('teacher') ? 'teacher' : 'student';
      setState(() {
        menuItems = _buildMenuItems(context, role);
      });
    } else {
      setState(() {
        menuItems = [];
      });
    }
  }

  List<Widget> _buildMenuItems(BuildContext context, String role) {
    List<Widget> items = [
      _buildMenuItem(
        context,
        'Home',
        Icons.home,
        () => _navigateToHome(context),
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
        'Performance',
        Icons.show_chart,
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Performance(studentId: '65defb8f796124616d1ecdc2')),
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
    ];

    if (role == 'teacher') {
      items.addAll([
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
      ]);
    } else {
      items.add(
        _buildMenuItem(
          context,
          'Review space',
          Icons.description,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TestBlanc()),
          ),
        ),
      );
    }

    items.add(
      _buildMenuItem(
        context,
        'Logout',
        Icons.logout,
        () => logout(context),
      ),
    );

    return items;
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

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => Scene1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildProfileHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: menuItems,
            ),
          ),
        ],
      ),
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
}