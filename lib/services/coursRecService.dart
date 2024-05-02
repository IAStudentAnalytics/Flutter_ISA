
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:pim/models/CoursR.dart';

class CoursService {
  static Future<List<CoursR>> fetchCours() async {
    final response = await http.get(Uri.parse('http://192.168.1.19:5000/cours/rec'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) {
        if (item['nomCoursR'] != null &&
            item['description'] != null &&
            item['pdff'] != null) {
          return CoursR(
            id: item['_id'],
            nomCoursR: item['nomCoursR'],
            description: item['description'],
            pdff: item['pdff'],
          );
        } else {
          throw Exception('Données incomplètes pour le cours');
        }
      }).toList();
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  static Future<void> deleteCours(String id) async {
    final response = await http.delete(Uri.parse('http://172.16.6.189:5000/cours/recid/$id'));

    if (response.statusCode != 200) {
      print('Code de statut HTTP: ${response.statusCode}');
      print('Corps de la réponse: ${response.body}');
      throw Exception('Échec de la suppression du cours');
    }
  }

  static Future<void> addCours(String nomCoursR, String description, Uint8List pdfBytes) async {
    final String apiUrl = 'http://172.16.6.189:5000/cours/rec';
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['nomCoursR'] = nomCoursR;
    request.fields['description'] = description;
    request.files.add(http.MultipartFile.fromBytes('source', pdfBytes, filename: 'file.pdf', contentType: MediaType('application', 'pdf')));

    var response = await request.send();

    if (response.statusCode != 200) {
      print('Code de statut HTTP: ${response.statusCode}');
      print('Corps de la réponse: ${response.stream.bytesToString()}');
      throw Exception('Échec de l\'ajout du cours');
    }
  }
}

/*shih get delet
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pim/models/CoursR.dart';

class CoursService {
  static Future<List<CoursR>> fetchCours() async {
    final response = await http.get(Uri.parse('http://localhost:9090/cours/rec'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) {
        if (item['nomCoursR'] != null &&
            item['description'] != null &&
            item['pdff'] != null) {
          return CoursR(
            id: item['_id'],  
            nomCoursR: item['nomCoursR'],
            description: item['description'],
            pdff: item['pdff'],
          );
        } else {
          throw Exception('Données incomplètes pour le cours');
        }
      }).toList();
    } else {
      throw Exception('Échec de la récupération des cours');
    }
  }

  static Future<void> deleteCours(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:9090/cours/recid/$id'));

    if (response.statusCode != 200) {
      print('Code de statut HTTP: ${response.statusCode}');
      print('Corps de la réponse: ${response.body}');
      throw Exception('Échec de la suppression du cours');
    }
  }
}*/