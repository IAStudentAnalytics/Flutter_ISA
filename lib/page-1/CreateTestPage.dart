import 'package:flutter/material.dart';
import 'package:pim/models/test.dart';
import 'package:pim/page-1/CreateQuestionPage.dart';
import 'package:pim/page-1/side_menu.dart';

class CreateTestPage extends StatefulWidget {
  @override
  _CreateTestPageState createState() => _CreateTestPageState();
}

class _CreateTestPageState extends State<CreateTestPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  List<Test> tests = [];

  void navigateToCreateQuestion(BuildContext context) {
    String title = titleController.text;
    String description = descriptionController.text;
    int duration = int.parse(durationController.text);

    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CreateQuestionPage(
        questions: [],
        onSubmitTest: (title, description, duration, questions) {
          _submitTest(title, description, duration, questions );
        }, title: title,description: description,duration: duration,tests: tests,
      ),
    ),
  );

  }

  void _submitTest(String title, String description, int duration, List<Question> questions) {
    // Implement the logic to submit the test
    // You can use the provided parameters to create a Test object
    // For example:
    Test test = Test(
      title: title,
      description: description,
      duration: duration,
      questions: questions,
      creationDate: DateTime.now(),
    );

    // After creating the test, you can handle it as needed
    // For example, you can save it to a database or display it on a screen
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fem = screenWidth / 411;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Test'),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffdf0b0b), Color(0x00f6f1fb)],
                stops: [0, 1],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0 * fem),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16 * fem),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16 * fem),
                  TextField(
                    controller: durationController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Duration (minutes)',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 32 * fem),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          navigateToCreateQuestion(context);
                        },
                        child: Text('Next', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Align(
                alignment: Alignment.center,
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  heightFactor: 0.5,
                  child: Image.asset(
                    'assets/page-1/images/n-removebg-preview-5.png',
                    fit: BoxFit.cover, // Adjust how the image should be fitted
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: SideMenu(onMenuItemClicked: (int) {}),
    );
  }
  Widget buildMenuButton(BuildContext context, double fem, String text, IconData icon, String route) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16.0 * fem, vertical: 12.0 * fem),
        // Adjust button size according to screen size
        minimumSize: Size(150 * fem, 50 * fem),
      ),
    );
  }
}