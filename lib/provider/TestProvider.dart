// test_provider.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:pim/models/test.dart';
const String baseUrl = 'http://localhost:51766';

class TestProvider extends ChangeNotifier {
  Test? test;
  List<Test> _tests = [];
  List<Test> get tests => _tests;

Future<List<Test>?> fetchTests() async {
  List<Test>? result;
  try {
    final response = await http.get(Uri.parse('$baseUrl/test/getAllTests'));
    if (response.statusCode == 200) {
      print('Tests fetched successfully. Status code: ${response.statusCode}');
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Test> tests = jsonData.map((json) => Test.fromJson(json)).toList();
      setTest(tests);
      return tests;
    } else {
      print('Failed to fetch tests: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching tests: $error');
    setTest([]);
  }
  return result;
}




Future<void> addTest(String title, String description, int duration, List<Map<String, dynamic>> questions, DateTime testDate) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/test/createTest'),
      body: jsonEncode({
        'title': title,
        'description': description,
        'duration': duration,
        'questions': questions,
        'testDate': testDate.toIso8601String(), // Convert DateTime to ISO 8601 string
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
}

