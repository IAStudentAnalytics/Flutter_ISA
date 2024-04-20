import 'dart:convert';
import 'package:http/http.dart' as http;
import '../apiConstants.dart';
import '../models/quiztestblanc.dart';

class TestBlancService {
  static Future<List<QuizQuestion>> fetchQuizQuestions() async {
    final response =
        await http.get(Uri.parse('${APIConstants.baseURL}/testblanc/test'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey('quiz')) {
        final List<dynamic> quizData = jsonResponse['quiz'];
        return quizData.map((item) {
          return QuizQuestion(
            question: item['question'],
            answers: List<String>.from(item['answers']),
            correctAnswer: item['correctAnswer'],
            chapter: item['Chapter'],
          );
        }).toList();
      } else {
        throw Exception('Clé "quiz" non trouvée dans la structure JSON');
      }
    } else {
      throw Exception(
          'Échec du chargement des questions de quiz : ${response.statusCode}');
    }
  }
  
}