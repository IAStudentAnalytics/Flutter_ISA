import 'dart:convert';
import 'package:http/http.dart' as http;
import '../apiConstants.dart';

class CompilerService {
  static Future<String> runCode(String code) async {
    try {
      final response = await http.post(
        Uri.parse('${APIConstants.baseURL}/compilateur/run-code'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'script': code}),
      );

      final data = jsonDecode(response.body);
      return data['output'];
    } catch (error) {
      print('Erreur lors de l\'exécution du code : $error');
      return '';
    }
  }
   Future<Map<String, dynamic>> fetchRecommendedVideos(String testId, String studentId) async {
    final response = await http.get(Uri.parse('http://127.0.0.1:60430/note/rec/$testId/$studentId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['recommendedVideos'];
    } else {
      throw Exception('Failed to load recommended videos');
    }
  }
}
