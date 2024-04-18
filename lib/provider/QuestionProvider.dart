/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:pim/models/test.dart';
const String baseUrl = 'http://localhost:64237';

class QuestionProvider extends ChangeNotifier {
  List<Question> _questions = [];

  List<Question> get questions => _questions;

  Future<void> addQuestion(Question question) async {
    try {
      // Convert the question object to JSON
      Map<String, dynamic> requestBody = question.toJson();

      // Determine the API endpoint based on the question type
      String endpoint = question.type == 'Quiz'
          ? '$baseUrl/Question/createQuizQuestion'
          : '$baseUrl/Question/createQAQuestion';

      // Make the HTTP POST request to the appropriate endpoint
      final response = await http.post(
        Uri.parse(endpoint),
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        // If the question is successfully created on the backend, add it to the local list
        _questions.add(question);
        notifyListeners();
      } else {
        // Handle the error if the request fails
        print('Failed to add question: ${response.statusCode}');
        print('Response body: ${response.body}');
        // You can throw an error or handle it as needed
      }
    } catch (error) {
      print('Error adding question: $error');
      // Handle the error as needed
    }
  }

  void setQuestions(List<Question> questions) {
    _questions = questions;
    notifyListeners();
  }
}


*/