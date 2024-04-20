import 'package:flutter/material.dart';
import 'package:pim/page-1/CreateQuestionPage.dart';
import 'package:pim/page-1/side_menu.dart'; // Import side menu widget
import 'package:pim/provider/TestProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TestProvider()),
        // Add other providers if needed
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduSwift',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scene1(),
      routes: {
        '/create_test': (context) => CreateQuestionPage( onSubmitQuestions: (questions) {  },
                    ),
      },
    );
  }
}

class Scene1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Adjust layout based on screen width
          if (constraints.maxWidth > 600) {
            return WideLayout();
          } else {
            return NarrowLayout();
          }
        },
      ),
    );
  }
}

class WideLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider( // Wrap with MultiProvider
        providers: [
          ChangeNotifierProvider(create: (_) => TestProvider()), // Provide the TestProvider
        ],
        child: Row(
          children: [
            SideMenu(onMenuItemClicked: (int) {}), 
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/create_test');
                      },
                      child: Text('Create Test'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add functionality for other actions
                      },
                      child: Text('Other Action'),
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
}

class NarrowLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider( // Wrap with MultiProvider
        providers: [
          ChangeNotifierProvider(create: (_) => TestProvider()), // Provide the TestProvider
        ],
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/create_test');
            },
            child: Text('Create Test'),
          ),
        ),
      ),
    );
  }
}
