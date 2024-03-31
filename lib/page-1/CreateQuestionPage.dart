import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pim/models/test.dart';
import 'package:pim/page-1/TestsHistory.dart';
import 'package:pim/page-1/side_menu.dart';

class CreateQuestionPage extends StatefulWidget {
  final List<Question> questions;
  final Function(String, String, int, List<Question>) onSubmitTest;
  final String title;
  final String description;
  final int duration;
  final List<Test> tests;
 
  CreateQuestionPage({
    required this.questions,
    required this.onSubmitTest,
    required this.title,
    required this.description,
    required this.duration,
    required this.tests,
    });

  @override
  _CreateQuestionPageState createState() => _CreateQuestionPageState();
}

class _CreateQuestionPageState extends State<CreateQuestionPage> {
  TextEditingController questionController = TextEditingController();
  TextEditingController complexityController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController marksController = TextEditingController();

  bool isQuizQuestion = true;
  List<Option> options = [];
  TextEditingController answerController = TextEditingController();
  File? _image;
  List<String> keywords = [];
  bool _isCreatingNewQuestion = true;

  void _saveQuestion() {
    // Initialize response variable
    String response;

    // Determine the response based on question type
    if (isQuizQuestion) {
      // Find the selected option
      Option selectedOption = options.firstWhere((option) => option.isCorrect, orElse: () => Option(text: ''));
      // Assign the text of the selected option as the response
      response = selectedOption.text;
    } else {
      // For non-quiz questions, use the text from the answerController
      response = answerController.text;
    }

    // Create a Question object using the data entered in the text fields
    Question question = Question(
      complexity: int.parse(complexityController.text),
      question: questionController.text,
      response: response,
      marks: int.parse(marksController.text),
      options: options.map((option) => option.text).toList(),
      type: isQuizQuestion ? 'Quiz' : 'QA',
      image: _image,
    );

    // Add the question object to the list of questions
    widget.questions.add(question);

    // Print a confirmation message
    print('Question saved!');
  }

  void _submitTest() {
  // Create a new Test object with the provided data
  Test test = Test(
    title: widget.title,
    description: widget.description,
    duration: widget.duration,
    creationDate: DateTime.now(),
    questions: widget.questions,
  );

  // Update the list of tests in the TestsHistory widget
  List<Test> updatedTests = List.from(widget.tests);
  updatedTests.add(test);

  // Navigate to the test history page, passing the updated list of tests
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TestsHistory(tests: updatedTests),
    ),
  );
}


  void _addAnotherQuestion() {
    _saveQuestion();
    print('Question Saved!'); // Save the current question

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateQuestionPage(
          questions: widget.questions,
          onSubmitTest: widget.onSubmitTest,
          title: widget.title,
          description: widget.description,
          duration: widget.duration,
          tests: widget.tests,
          ),
      ),
    ).then((_) {
      setState(() {
        _isCreatingNewQuestion = true; // Set to true when creating a new question
      });
    });
  }

  Future<void> _getImage(ImageSource source) async {
 final pickedFile = await ImagePicker().pickImage(source: source);


    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageController.text = _image!.path;
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fem = screenWidth / 411;

    return WillPopScope(
      onWillPop: () async {
        // Add logic here if needed when the back button is pressed
        return true; // Return true to allow back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isCreatingNewQuestion ? 'Create Question' : 'Previous Question'),
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
                  colors: [Color(0xffdf0b0b), Color(0x00f6f1fb) ],
                  stops: [0, 1],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: questionController,
                      decoration: InputDecoration(
                        labelText: 'Question',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 10 * fem),
                    CheckboxListTile(
                      title: Text('Quiz Question'),
                      value: isQuizQuestion,
                      onChanged: (value) {
                        setState(() {
                          isQuizQuestion = value!;
                          options = [];
                        });
                      },
                    ),
                    if (isQuizQuestion)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Options:'),
                          SizedBox(height: 8 * fem),
                          for (int i = 0; i < options.length; i++)
                            ListTile(
                              leading: Icon(Icons.drag_handle),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Option ${i + 1}',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(0.8),
                                      ),
                                      onChanged: (value) {
                                        options[i].text = value;
                                      },
                                    ),
                                  ),
                                  Checkbox(
                                    value: options[i].isCorrect,
                                    onChanged: (value) {
                                      setState(() {
                                        options[i].isCorrect = value ?? false;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        options.removeAt(i);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(height: 8 * fem),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                options.add(Option());
                              });
                            },
                            child: Text('Add Option'),
                          ),
                        ],
                      )
                    else
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Keywords (comma-separated)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    SizedBox(height: 16 * fem),
                    TextField(
                      controller: complexityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Complexity',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 16 * fem),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: imageController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Image URL',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        SizedBox(
                          height: 48.0,
                          child: ElevatedButton(
                            onPressed: () {
                              _getImage(ImageSource.gallery);
                            },
                            child: Text('Select Image'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16 * fem),
                    TextField(
                      controller: marksController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Marks',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 32 * fem),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: ElevatedButton(
                              onPressed: (){
                                _submitTest();
                                _saveQuestion();
                              },
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('Submit Test'),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () {
                                _addAnotherQuestion();
                              },
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('Add Another Question'),
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
      ),
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

class Option {
  String text;
  bool isCorrect;

  Option({this.text = '', this.isCorrect = false});
}