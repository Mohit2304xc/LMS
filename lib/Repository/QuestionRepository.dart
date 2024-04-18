//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Model/QuestionPaperModel.dart';

class QuestionRepository extends GetxController {
  static QuestionRepository get instance => Get.find();

  //final _db = FirebaseFirestore.instance;


  // Future<List<Question>> fetchQuestions(String examTitle) async {
  //   const url = 'https://server4.prabisha.com/api/quiz';
  //   final response = await http.get(Uri.parse(url));
  //   print(examTitle);
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body)['data'];
  //     final List<Question> allQuestions = data.map((json) => Question.fromJson(json)).toList();
  //     print(allQuestions);
  //     // Filter questions based on exam title
  //     final List<Question> filteredQuestions = allQuestions.where((question) => question.topic == examTitle).toList();
  //     print(filteredQuestions);
  //     return filteredQuestions;
  //   } else {
  //     throw Exception('Failed to load questions');
  //   }
  // }


/*Future<void> addQuestionToFirebase(Question question, String title) async {
    try {
      await _db
          .collection("exams")
          .doc(title)
          .collection("questions")
          .add(question.toMap());
    } catch (e) {
      throw "Something went wrong.";
    }
  }*/
}
