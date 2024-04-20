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
}
