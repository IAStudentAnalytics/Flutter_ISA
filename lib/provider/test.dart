// test_provider.dart
import 'package:flutter/foundation.dart';
import 'package:pim/models/test.dart';

class TestProvider extends ChangeNotifier {
  Test? _test;
  List<Test> _tests = [];
  Test? get test => _test;
  List<Test> get tests => _tests;

  void addTest(Test test) {
    _tests.add(test);
    notifyListeners();
  }

  void setTest(Test test) {
    _test = test;
    notifyListeners();
  }
  
  void removeTest(Test test) {
    _tests.remove(test);
    notifyListeners();
  }
}


class QuestionProvider extends ChangeNotifier {
  List<Question> _questions = [];

  List<Question> get questions => _questions;

  void addQuestion(Question question) {
    _questions.add(question);
    notifyListeners();
  }
  
  void setQuestions(List<Question> questions) {
    _questions = questions;
    notifyListeners();
  }
}
