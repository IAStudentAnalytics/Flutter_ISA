class Test {
  final String? id;
  final List<Question> questions;
  late final String title;
  late final String description;
  final DateTime testDate;
  final int duration;
  final String studentsClass;

  Test({
    this.id,
    required this.questions,
    required this.title,
    required this.description,
    required this.testDate,
    required this.duration,
    required this.studentsClass,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['_id'],
      questions: (json['questions'] as List<dynamic>?)?.map((q) => Question.fromJson(q)).toList() ?? [],
      title: json['title'],
      description: json['description'],
      testDate: DateTime.parse(json['testDate']),
      duration: json['duration'],
      studentsClass: json['studentsClass']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questions': questions.map((q) => q.toJson()).toList(),
      'title': title,
      'description': description,
      'testDate': testDate.toIso8601String(),
      'duration': duration,
      'studentsClass': studentsClass,
    };
  }
}

class Question {
  final String? id;
  final int complexity;
  final String question;
  final String response;
  final int marks;
  final List<String>? options;
  final String? chapitre;
  final String type;

  Question({
    this.id,
    required this.complexity,
    required this.question,
    required this.response,
    required this.marks,
    this.options,
    this.chapitre,
    required this.type,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['_id'],
      complexity: json['complexity'],
      question: json['question'],
      response: json['response'],
      marks: json['marks'],
      options: List<String>.from(json['options']),
      chapitre: json['chapitre'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'complexity': complexity,
      'question': question,
      'response': response,
      'marks': marks,
      'options': options,
      'chapitre': chapitre,
      'type': type,
    };
  }
}
