import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pim/models/test.dart';
import 'package:pim/provider/TestProvider.dart';
import 'package:pim/page-1/side_menu.dart';
import 'package:provider/provider.dart';

class TestsHistory extends StatefulWidget {
  final Function(int) onMenuItemClicked;
  TestsHistory({required this.onMenuItemClicked, required List<Test> tests});

  @override
  _TestsHistoryState createState() => _TestsHistoryState();
}

class _TestsHistoryState extends State<TestsHistory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Test updatedTest ;

  @override
  void initState() {
    final testProvider = Provider.of<TestProvider>(context, listen: false);
    super.initState();
    print('Fetching tests...');
    testProvider.fetchTests().then((_) {
      print('Tests fetched successfully. Total tests: ${testProvider.tests}');
    }).catchError((error) {
      print('Error fetching tests: $error');
    });
  }

  void _sortByAlphabet() {
    final testProvider = Provider.of<TestProvider>(context, listen: false);
    setState(() {
      testProvider.tests.sort((a, b) => a.title.compareTo(b.title));
    });
  }

  void _sortByDate() {
    final testProvider = Provider.of<TestProvider>(context, listen: false);
    setState(() {
      testProvider.tests.sort((a, b) => a.testDate.compareTo(b.testDate));
    });
  }

  String? generateUniqueCode() {
    // Generate a random unique code
    var random = Random();
    return random.nextInt(999999).toString().padLeft(6, '0');
  }

  @override
  Widget build(BuildContext context) {
    var testProvider = Provider.of<TestProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tests History'),
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
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: _sortByAlphabet,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('Sort by Alphabet'),
                      ),
                    ),
                  ),
                  SizedBox(width: 2),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: _sortByDate,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('Sort by Date'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: testProvider.tests.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(), // Show loading indicator
                      )
                    : Consumer<TestProvider>(
                        builder: (context, testProvider, child) {
                          return ListView.builder(
                            itemCount: testProvider.tests.length,
                            itemBuilder: (context, index) {
                              final Test test = testProvider.tests[index];
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          String uniqueCode = generateUniqueCode() ?? '';
                                          final qrImageData = await QrPainter(
                                            data: 'Test :${test.title},Date : ${test.testDate}, Access Code : $uniqueCode',
                                            version: QrVersions.auto,
                                            gapless: false,
                                          ).toImageData(200);

                                          // Show the test details in a popup
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(test.title),
                                              content: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('Description: ${test.description}'),
                                                  Text('Date: ${test.testDate.toString()}'),
                                                  Text('Duration: ${test.duration.toString()}'),
                                                  Text('Questions: ${test.questions.length}'),
                                                  // Add more details as needed
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                                    child: Center(
                                                      child: SizedBox(
                                                        width: 100, // Adjust the width as needed
                                                        height: 100, // Adjust the height as needed
                                                        child: Image.memory(
                                                            qrImageData!.buffer.asUint8List()), // Display the QR code image
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Close'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: ListTile(
                                          title: Text(test.title),
                                          subtitle: Text(test.testDate.toString()),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        // Show confirmation dialog before deleting
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text('Confirm Deletion'),
                                            content: Text('Are you sure you want to delete this test?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context); // Close dialog
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  // Perform deletion logic here
                                                  // Remove the test from the list
                                                  setState(() {
                                                    testProvider.removeTest(test.id!);
                                                  });
                                                  Navigator.pop(context); // Close dialog
                                                },
                                                child: Text('Delete'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        // Show modify test popup
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text('Modify Test'),
                                            content: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                initialValue: test.title,
                                                decoration: InputDecoration(labelText: 'Title'),
                                                onChanged: (value) {
                                                  // Update the title of the selected test
                                                  setState(() {
                                                    updatedTest.title = value;
                                                  });
                                                },
                                              ),
                                              TextFormField(
                                                initialValue: test.description,
                                                decoration: InputDecoration(labelText: 'Description'),
                                                onChanged: (value) {
                                                  // Update the description of the selected test
                                                  setState(() {
                                                    updatedTest.description = value;
                                                  });
                                                },
                                              ),
                                              SizedBox(width: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    child: Text('Save'),
                                                  ),
                                                  SizedBox(width: 2), // Add padding between the buttons
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Cancel'),
                                                  ),
                                                ],
                                              )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
   drawer: SideMenu(onMenuItemClicked: (int) {}),
    );
  }
}