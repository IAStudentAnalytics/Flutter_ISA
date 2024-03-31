// test.dart
import 'dart:io';

class Test {
  final DateTime creationDate;
  final String title;
  final String description;
  final int duration;
  final List<Question> questions;

  Test({
    required this.creationDate,
    required this.title,
    required this.description,
    required this.duration,
    required this.questions,
  });
}

// question.dart

class Question {
  int complexity;
  String question;
  String response;
  int marks;
  List<String> options;
  String type;
  File? image;

  Question({
    required this.complexity,
    required this.question,
    required this.response,
    required this.marks,
    required this.options,
    required this.type,
    this.image,
  });
}