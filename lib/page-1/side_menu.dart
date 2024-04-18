import 'package:flutter/material.dart';
import 'package:pim/page-1/compilateur.dart';
import 'package:pim/page-1/login.dart';
import 'package:pim/page-1/quizzteacher.dart';
import 'package:pim/page-1/resultquiz-FFc.dart';
import 'package:pim/page-1/teacherhome.dart';
import 'package:pim/page-1/javabot.dart';
import 'package:pim/page-1/performance.dart';
import 'package:pim/page-1/testblanc.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Text('Welcome to my app'),
      ),
      drawer: SideMenu(
        onMenuItemClicked: (index) {
          // Gérer les clics sur les éléments du menu
          // Vous pouvez mettre votre logique ici pour naviguer vers différentes pages
          // ou effectuer d'autres actions en fonction de l'index
          print('Menu item clicked: $index');
        },
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  final Function(int) onMenuItemClicked;

  const SideMenu({Key? key, required this.onMenuItemClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red, Colors.white],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(132, 199, 37, 37),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Home '),
             onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Sceneteacherhome(),
          ));
        },
            ),
             ListTile(
              title: Text('Java Bot'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JavaBotPage()),
                );
              },
            ),
             ListTile(
              title: Text('Quizz !'),
             onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Scenequizzteacher()),
          );
        },
            ),
            ListTile(
              title: Text('Result'),
              onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResultQuiz()),
          );
        },
            ),
             ListTile(
              title: Text('Compilateur Java !'),
             onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CompilerPage()),
          );
        },
            ),
               ListTile(
              title: Text('Performance !'),
             onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Performance()),
          );
        },
            ),
              ListTile(
              title: Text('Test Blanc !'),
             onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TestBlanc()),
          );
        },
            ),
          ListTile(
  title: Text('Logout'),
  onTap: () async {
    // Obtain shared preferences instance
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Clear all data stored in SharedPreferences
    await prefs.clear();

    // Optionally, if you want to remove only specific data like the token:
    // await prefs.remove('token');  // if you're storing the token under the key 'token'

    // Navigate to the login page and remove all routes (so user can't go back to the previous screens)
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Scene1()),
      (Route<dynamic> route) => false,
    );
  },
            ),
          ],
        ),
      ),
    );
  }
}
