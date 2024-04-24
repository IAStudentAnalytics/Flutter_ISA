
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pim/page-1/CreateTestPage.dart';

class CreateQuestionPage extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onSubmitQuestions;

  CreateQuestionPage({
    required this.onSubmitQuestions
  });

  @override
  _CreateQuestionPageState createState() => _CreateQuestionPageState();
}

class _CreateQuestionPageState extends State<CreateQuestionPage> {
  TextEditingController questionController = TextEditingController();
  TextEditingController marksController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  int? selectedComplexity;
  String? selectedChapter;

  final List<String> chapters = [
    'Les classes et les objets',
    'L héritage',
    'Le polymorphisme',
    'Les interfaces',
    'Encapsulation'
  ];

  File? _image;
  List<Option> options = [];
  bool isQuizQuestion = true;
  List<Map<String, dynamic>> questions = [];

  void _addQuestion() {
  if (_areFieldsEmpty()) {
    _showAlert('Please fill all fields before adding a question.');
    return;
  }

  Map<String, dynamic> newQuestion = {
    'complexity': int.parse(selectedComplexity.toString()),
    'question': questionController.text,
    'response': answerController.text,
    'marks': int.parse(marksController.text),
    'options': options.map((option) => option.text).toList(),
    'chapitre': selectedChapter,
    'type': isQuizQuestion ? 'Quiz' : 'QA',
    'image': _image.toString(),
  };

  // Append the new question to the list of questions
  setState(() {
    questions.add(newQuestion);
  });

  // Clear the text fields and options
  _clearFields();
  widget.onSubmitQuestions(questions);
}
  void _saveQuestions() {
  if (questions.isEmpty) {
    _showAlert('No questions to save.');
    return;
  }

  List<Map<String, dynamic>> savedQuestions = List.from(questions);
  questions.clear();
  print('Saved Questions : $savedQuestions');
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CreateTestPage(questions: savedQuestions),
    ),
  );

  _showAlert('Questions saved successfully.');
  widget.onSubmitQuestions(questions);
}

  bool _areFieldsEmpty() {
    return questionController.text.isEmpty ||
        marksController.text.isEmpty;
  }

  void _clearFields() {
    questionController.clear();
    marksController.clear();
    answerController.clear();
    imageController.clear();
    setState(() {
      _image = null;
    });
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fem = screenWidth / 411;

    return Scaffold(
        appBar: AppBar(
          title: Text('Create Questions'),
        ),
        body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffdf0b0b), Color(0x00f6f1fb)],
              stops: [0, 1],
            ),
          ),
      child: Padding(
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
            DropdownButtonFormField<String>(
              value: selectedChapter,
              onChanged: (value) {
                setState(() {
                  selectedChapter = value;
                });
              },
              items: chapters.map((chapter) {
                return DropdownMenuItem<String>(
                  value: chapter,
                  child: Text(chapter),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Chapter',
                filled: true,
                fillColor: Colors.white.withOpacity(0.8), // Set background color to white
                border: OutlineInputBorder( // Define border
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none, // Define border color
                ),
                // Add additional styling properties as needed
                // You can customize labelStyle, hintStyle, and more
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
                                if (value ?? false) {
                                  answerController.text = options[i].text;
                                }
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
                controller: answerController,
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
            Row(
              children: [
                Text('Complexity:'),
                SizedBox(width: 10),
                Row(
                  children: [
                    Radio<int>(
                      value: 1,
                      groupValue: selectedComplexity,
                      onChanged: (value) {
                        setState(() {
                          selectedComplexity = value;
                        });
                      },
                    ),
                    Text('1'),
                  ],
                ),
                Row(
                  children: [
                    Radio<int>(
                      value: 2,
                      groupValue: selectedComplexity,
                      onChanged: (value) {
                        setState(() {
                          selectedComplexity = value;
                        });
                      },
                    ),
                    Text('2'),
                  ],
                ),
                Row(
                  children: [
                    Radio<int>(
                      value: 3,
                      groupValue: selectedComplexity,
                      onChanged: (value) {
                        setState(() {
                          selectedComplexity = value;
                        });
                      },
                    ),
                    Text('3'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16 * fem),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
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
                    controller: TextEditingController(text: _image?.path ?? ''),
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(
                  height: 48.0,
                  child: ElevatedButton(
                    onPressed: () {
                      _getImage();
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
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _addQuestion();
                  },
                  child: Text('Add Question'),
                ),
                ElevatedButton(
                  onPressed: _saveQuestions,
                  child: Text('Save Questions'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Questions:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(questions[index]['question']),
                  subtitle: Text('Complexity: ${questions[index]['complexity']}, Marks: ${questions[index]['marks']}'),
                  leading: questions[index]['image'] != null ? Image.network(questions[index]['image']) : null ,
                );
              },
            ),
          ],
        ),
        ),
      ),
    ),
  ),
    );
  }
}


class Option {
  String text;
  bool isCorrect;
  Option({this.text = '', this.isCorrect = false});
}