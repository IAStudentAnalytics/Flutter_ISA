import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:pim/page-1/CreateTestPage.dart';
import 'package:pim/page-1/TestsHistory.dart';
import 'package:pim/page-1/quiz.dart';
import 'package:pim/page-1/quiz_new.dart';
import 'package:pim/utils.dart';

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
	return MaterialApp(
		title: 'EduSwift',
		debugShowCheckedModeBanner: false,
		scrollBehavior: MyCustomScrollBehavior(),
		theme: ThemeData(
		primarySwatch: Colors.blue,
		),
          routes: {
     
        '/create_test': (context) => CreateTestPage(),
        //'/list_students': (context) => ListOfStudentsPage(),
        '/tests_history': (context) => TestsHistory(tests: [],),
        // Ajoutez d'autres routes ici au besoin
      },

		home: Scaffold(
		body: SingleChildScrollView(
			child: Scene1(),
		),
		),
	);
  
	}
}