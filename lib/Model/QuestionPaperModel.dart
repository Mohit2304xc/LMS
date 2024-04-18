//import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String id;
  final String topic;
  final String question;
  final List<String> options;
  final String correctAnswer;


  Question({
    required this.id,
    required this.topic,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  /*factory Question.fromDocument(DocumentSnapshot doc) {
    return Question(
      questionText: doc['questionText'],
      options: List<String>.from(doc['options']),
      correctAnswer: doc['correctAnswer'],
    );
  }*/

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['Id'].toString(),
      topic: json['Topic'],
      question: json['Question'],
      correctAnswer: json['Correct_ans'],
      options: [
        json['Option1'],
        json['Option2'],
        json['Option3'],
        json['Option4'],
      ],
    );
  }

  /*Map<String, dynamic> toMap() {
    return {
      'questionText': question,
      'options': options,
      'correctAnswer': correctAnswer,
    };
  }*/
}