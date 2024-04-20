// services/cours_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pim/models/CoursR.dart';

class CoursRecService {
  static Future<List<CoursR>> fetchCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/cours/rec'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) {
        return CoursR(
          nomCoursR: item['nomCoursR'],
          description: item['description'],
          pdff: item['pdff'],
        );
      }).toList();
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  static Future<void> deleteCours(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:9090/cours/recid/$id'));

    if (response.statusCode != 200) {
      throw Exception('Échec de la suppression du cours');
    }
  }
}
