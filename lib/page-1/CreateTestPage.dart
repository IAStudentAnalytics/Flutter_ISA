import 'package:flutter/material.dart';
import 'package:pim/models/test.dart';
import 'package:pim/page-1/TestsHistory.dart';
import 'package:pim/page-1/side_menu.dart';
import 'package:pim/provider/TestProvider.dart';
import 'package:provider/provider.dart';

class CreateTestPage extends StatefulWidget {
  late final List<Map<String, dynamic>> questions;
  CreateTestPage({Key? key, required this.questions}) : super(key: key); // Add this constructor
 // Add this line
  @override
  _CreateTestPageState createState() => _CreateTestPageState();
}

class _CreateTestPageState extends State<CreateTestPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<Test> tests = [];
  List<Map<String, dynamic>> questions = [];
  Duration selectedDuration = Duration(hours: 0, minutes: 0);
  DateTime? selectedDateTime;
  
  void addTest() {
    final testProvider = Provider.of<TestProvider>(context, listen: false);
    
    // Get the values of the text controllers
    String title = titleController.text;
    String description = descriptionController.text;
    int duration = selectedDuration.inSeconds;
    print('duration: $duration'); // Convert duration to seconds
    // Check if questions list is not null and not empty
    if (widget.questions.isNotEmpty) {
      // Ensure all required fields in each question are populated
      List<Map<String, dynamic>> validQuestions = widget.questions.where((q) => q['question'] != null && q['response'] != null).toList();
      
      // Call the addTest method with the required parameters
      testProvider.addTest(title, description, duration, validQuestions, selectedDateTime!);
      print('Test created - Title: $title, Description: $description, Duration: $duration, Questions: $validQuestions, Test Date: $selectedDateTime');
    } else {
      print('Questions list is null or empty');
    }
    // Navigate to the test history page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TestsHistory(tests: [], onMenuItemClicked: (int ) {  },)),
    );
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
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0 mins'),
                    IconButton(
                      onPressed: () {
                        if (selectedDuration.inMinutes > 0) {
                          setState(() => selectedDuration -= Duration(minutes: 5));
                        }
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.transparent),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Duration',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.transparent),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Slider(
                                    value: selectedDuration.inMinutes.toDouble(),
                                    min: 0,
                                    max: 120,
                                    divisions: 24,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedDuration = Duration(minutes: value.toInt());
                                      });
                                    },
                                  ),
                                  Text(
                                    '${selectedDuration.inMinutes} mins',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() => selectedDuration += Duration(minutes: 5));
                      },
                      icon: Icon(Icons.add),
                    ),
                    Text('120 mins'),
                  ],
                ),
                  SizedBox(height: 16 * fem),
                  Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
              title: Text('Select Date and Time:'),
              trailing: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)), // Allow selecting dates within the next year
                  );
                  if (pickedDate != null) {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        selectedDateTime = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                      });
                    }
                  }
                },
              ),
              subtitle: selectedDateTime != null
                ? Text('Selected Date and Time: ${selectedDateTime!.toString()}')
                : Text('Select Date and Time'),
            ),
            ),
            SizedBox(height: 16 * fem),
            Text(
                  'Questions:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.questions.length,
                    itemBuilder: (context, index) {
                      final question = widget.questions[index];
                      // Customize the appearance of each question item as needed
                      return ListTile(
                        title: Text(question['question']),
                        subtitle: Text(question['image'] ?? 'Image not available'),
                        // Add other details of the question if available
                      );
                    },
                  ),
                ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          addTest();
                        },
                        child: Text('Save Test', style: TextStyle(fontSize: 18)),
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
