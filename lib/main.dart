  import 'package:flutter/material.dart';
  import 'package:flutter/gestures.dart';
  import 'dart:ui';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:pim/page-1/CreateQuestionPage.dart';
  import 'package:pim/page-1/CreateTestPage.dart';
  import 'package:pim/page-1/TestsHistory.dart';
  import 'package:pim/page-1/information_page.dart';
  import 'package:pim/page-1/profile_page.dart';
  import 'package:pim/page-1/quiz.dart';
  import 'package:pim/page-1/quiz_new.dart';
  import 'package:pim/page-1/settings_page.dart';
  import 'package:pim/page-1/update_profile_page.dart';
  import 'package:pim/provider/TestProvider.dart';
  import 'package:pim/utils.dart';
  import 'package:provider/provider.dart';
  import 'package:get/get.dart';
  import 'package:shared_preferences/shared_preferences.dart';

  // import 'package:myapp/page-1/quiz.dart';
  // import 'package:myapp/page-1/resultquiz.dart';
  // import 'package:myapp/page-1/test.dart';
  // import 'package:myapp/page-1/resultquiz-FFc.dart';
  import 'page-1/login.dart';
  // import 'package:myapp/page-1/performance.dart';
  // import 'package:myapp/page-1/chathome.dart';
  // import 'page-1/chat.dart';
  // import 'package:myapp/page-1/info-box.dart';
  // import 'package:myapp/page-1/info-box-4XY.dart';
  // import 'package:myapp/page-1/homestudent.dart';
  // import 'package:myapp/page-1/hometeacher.dart';
  // import 'package:myapp/page-1/javabotbtn.dart';
  // import 'package:myapp/page-1/javabotbtn-rB8.dart';
  // import 'package:myapp/page-1/logoutbtn.dart';
  // import 'package:myapp/page-1/logout.dart';
  // import 'package:myapp/page-1/classes.dart';
  // import 'package:myapp/page-1/classesbtn.dart';
  // import 'package:myapp/page-1/resultbtn.dart';
  // import 'package:myapp/page-1/blue-robot-mascot-logo-icon-design675467-55-1-traced-1.dart';
  // import 'package:myapp/page-1/blue-robot-mascot-logo-icon-design675467-55-1-traced-1-uBC.dart';
  // import 'package:myapp/page-1/frame-2.dart';

  void main() => runApp(MyApp());

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
          return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TestProvider()),
          // Add more providers here if needed
        ],
        child: MaterialApp(

        title: 'EduSwift',
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
    routes: {
          '/create_test': (context) => CreateQuestionPage( onSubmitQuestions: (questions) {  },
                      ),
          '/tests_history': (context) => TestsHistory(tests: [], onMenuItemClicked: (int ) {  },),
          '/profile': (context) => ProfilePage(),
            '/update_profile': (context) => UpdateProfilePage(),
            '/settings': (context) => SettingsPage(),
            '/information': (context) => InformationPage(),
        },
        home: Scaffold(
          body: SingleChildScrollView(
            child: Scene1(),
          ),
        ),
      ),
          );
    }
  }




  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();  // Clear all SharedPreferences data

    // Navigate to the login page and remove all previous routes
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Scene1()), 
      (Route<dynamic> route) => false,
    );
  }

