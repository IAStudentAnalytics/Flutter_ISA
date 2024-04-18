/*// test_provider.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:pim/models/test.dart';
const String baseUrl = 'http://localhost:64237';

class TestProvider extends ChangeNotifier {
  Test? test;
  List<Test> _tests = [];
  List<Test> get tests => _tests;
  // Getters for individual attributes
  //String get id => id;
  String get title => title;
  String get description => description;
  int get duration => duration;
  List<String> get questions => questions;

Future<void> fetchTests() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/test/getAllTests'));
    if (response.statusCode == 200) {
    //r  print('Response body: ${response.body}'); // Print response body for debugging
      var decodedData = jsonEncode(response.body);
      print("aliiiii");
              print(decodedData);

      if (decodedData is List) {
        final List<Test> tests = decodedData.map((json) => Test.fromJson(json)).toList();
        setTest(tests); // Update the test provider with the fetched tests
      } else {
        print('Error: Response body is not a list');
      }
    } else {
      print('Failed to fetch tests: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching tests: $error');
  }
}



  Future<void> addTest() async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/test/createTest'),
      body: jsonEncode({
        'title': title, // Replace title with the appropriate value
        'description': description, // Replace description with the appropriate value
        'duration': duration, // Replace duration with the appropriate value
        'questions': questions, // Replace questions with the appropriate value
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      print('Test created successfully.');
      final Map<String, dynamic> testData = jsonDecode(response.body);
      final Test test = Test.fromJson(testData);
      // Update the test provider with the created test
      setTest([test]);
    } else {
      print('Failed to create test: ${response.statusCode}');
    }
  } catch (error) {
    print('Error creating test: $error');
  }
}


  
  void removeTest(Test test) {
    _tests.remove(test);
    notifyListeners();
  }
  
  void setTest(List<Test> tests) {
    _tests = tests;
    notifyListeners();
  }
}*/

