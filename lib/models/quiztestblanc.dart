class QuizQuestion {
  final String question;
  final List<String> answers;
  final String correctAnswer;
  final String chapter;

  QuizQuestion({
    required this.question,
    required this.answers,
    required this.correctAnswer,
    required this.chapter,
  });
}

class QuizData {
  final List<QuizQuestion> questions;
  final Map<String, double> chapterPercentages;

  QuizData({
    required this.questions,
    required this.chapterPercentages,
  });
}