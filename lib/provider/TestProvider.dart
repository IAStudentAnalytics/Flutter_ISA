// test_provider.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:pim/apiConstants.dart';
import 'package:pim/models/test.dart';
const String baseUrl = '${APIConstants.baseURL}';

class TestProvider extends ChangeNotifier {
  Test? test;
  List<Test> _tests = [];
  List<Test> get tests => _tests;

Future<List<Test>> fetchTests() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/test/getAllTests'));
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
      print('Tests fetched successfully. Status code: ${response.statusCode} , $jsonData');
      if (jsonData != null && jsonData is Iterable) {
        final List<Test> tests = jsonData.map((json) => Test.fromJson(json)).toList();
        setTest(tests);
        return tests;
      } else {
        print('Invalid JSON data');
        return [];
      }
    } else {
      print('Failed to fetch tests: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching tests: $error');
    setTest([]);
  }
  return tests;
}

Future<void> updateTest(String testId, Test updatedTest) async {
  try {
    final response = await http.put(
      Uri.parse('$baseUrl/test/updateTest/$testId'),
      body: json.encode(updatedTest.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      // Handle successful update, if needed
    } else {
      // Handle error response from the backend
      throw Exception('Failed to update test: ${response.reasonPhrase}');
    }
  } catch (error) {
    // Handle network errors
    throw Exception('Failed to update test: $error');
  }
}


Future<void> addTest(String title, String description, int duration, List<Map<String, dynamic>> questions, DateTime testDate, String studentsClass) async {
  try {
    final Uri url = Uri.parse('$baseUrl/test/createTest');

    final response = await http.post(
      url,
      body: jsonEncode({
        'title': title,
        'description': description,
        'duration': duration,
        'questions': questions,
        'testDate': testDate.toIso8601String(),
        'studentsClass': studentsClass, // Convert DateTime to ISO 8601 string
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



// Function to fetch image bytes from file path
Future<Uint8List> getImageBytes(String imagePath) async {
  print('Fetching image bytes from: $imagePath');
  try {
    final imageResponse = await http.get(Uri.parse(imagePath));
    print('Image fetch response status code: ${imageResponse.statusCode}');
    if (imageResponse.statusCode == 200) {
      print('Image fetched successfully');
      return imageResponse.bodyBytes;
    } else {
      print('Failed to fetch image: ${imageResponse.statusCode}');
      return Uint8List(0); // Return an empty list if image fetch fails
    }
  } catch (error) {
    print('Error fetching image: $error');
    return Uint8List(0); // Return an empty list if an error occurs
  }
}


Future<void> removeTest(String testId) async {
  try {
    final response = await http.delete(Uri.parse('$baseUrl/test/deleteTest/$testId'));
    if (response.statusCode == 200) {
      // Remove the test locally if deletion was successful
      _tests.removeWhere((test) => test.id == testId);
      notifyListeners();
    } else {
      // Handle error response from the backend
      throw Exception('Failed to delete test: ${response.reasonPhrase}');
    }
  } catch (error) {
    // Handle network errors
    throw Exception('Failed to delete test: $error');
  }
}
  
  void setTest(List<Test>? tests) {
    if (tests != null){
    _tests = tests;
    notifyListeners();
    } else {
      print('error : recieved null list for tests');
    }
  }
}

