import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;


  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
  });

  factory Question.fromDocument(DocumentSnapshot doc) {
    return Question(
      questionText: doc['questionText'],
      options: List<String>.from(doc['options']),
      correctAnswer: doc['correctAnswer'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'options': options,
      'correctAnswer': correctAnswer,
    };
  }
}