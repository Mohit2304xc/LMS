import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Model/QuestionPaperModel.dart';

class QuestionRepository extends GetxController {
  static QuestionRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<Question>> fetchQuestions(String examTitle) async {
    final querySnapshot = await _db
        .collection('exams')
        .doc(examTitle)
        .collection('questions')
        .get();

    return querySnapshot.docs.map((doc) => Question.fromDocument(doc)).toList();
  }

  Future<void> addQuestionToFirebase(Question question, String title) async {
    try {
      await _db
          .collection("exams")
          .doc(title)
          .collection("questions")
          .add(question.toMap());
    } catch (e) {
      throw "Something went wrong.";
    }
  }
}
