import 'package:flutter/material.dart';
import 'package:pim/page-1/login.dart';

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
              title: Text('Home'),
              onTap: () {
                onMenuItemClicked(0);
              },
            ),
            ListTile(
              title: Text('Talk with Bot'),
              onTap: () {
                onMenuItemClicked(1);
              },
            ),
            ListTile(
              title: Text('Result'),
              onTap: () {
                onMenuItemClicked(2);
              },
            ),
            ListTile(
              title: Text('Logout'),
             onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Scene1()),
          );
        },
            ),
          ],
        ),
      ),
    );
  }
}
