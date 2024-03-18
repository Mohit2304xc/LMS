import 'package:dummy1/Model/QuestionPaperModel.dart';
import 'package:dummy1/Repository/QuestionRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/Validators/Validation.dart';

class QuestionController extends GetxController {
  static QuestionController get instance => Get.find();

  final repo = Get.put(QuestionRepository());
  final title = TextEditingController();
  final correctAnswer = TextEditingController();
  final questionText = TextEditingController();
  final option1 = TextEditingController();
  final option2 = TextEditingController();
  final option3 = TextEditingController();
  final option4 = TextEditingController();

  Future<List<Question>> fetchQuestions(String examTitle) async {
    final result = await repo.fetchQuestions(examTitle);

    return result;
  }

  void inputTitleForDocumentUploadPopup() {
    Get.dialog(
      AlertDialog(
        title: const Text('Question'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: title,
                    expands: false,
                    validator: (value) =>
                        Validators.validateEmptyText("Enter Title", value),
                    decoration: const InputDecoration(labelText: 'Enter Title'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: correctAnswer,
                    expands: false,
                    validator: (value) =>
                        Validators.validateEmptyText("Enter Correct Answer", value),
                    decoration:
                        const InputDecoration(labelText: 'Enter Correct Answer'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: questionText,
              expands: false,
              validator: (value) =>
                  Validators.validateEmptyText("Enter question", value),
              decoration: const InputDecoration(labelText: 'Enter question'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: option1,
                    expands: false,
                    validator: (value) =>
                        Validators.validateEmptyText("Enter option 1", value),
                    decoration: const InputDecoration(labelText: 'Enter option 1'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: option2,
                    expands: false,
                    validator: (value) =>
                        Validators.validateEmptyText("Enter option 2", value),
                    decoration: const InputDecoration(labelText: 'Enter option 2'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: option3,
                    expands: false,
                    validator: (value) =>
                        Validators.validateEmptyText("Enter option 3", value),
                    decoration: const InputDecoration(labelText: 'Enter option 3'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: option4,
                    expands: false,
                    validator: (value) =>
                        Validators.validateEmptyText("Enter option 4", value),
                    decoration: const InputDecoration(labelText: 'Enter option 4'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final question = Question(
                    questionText: questionText.text,
                    options: [
                      option1.text,
                      option2.text,
                      option3.text,
                      option4.text
                    ],
                    correctAnswer: correctAnswer.text);
                repo.addQuestionToFirebase(question, title.text);
                title.clear();
                questionText.clear();
                correctAnswer.clear();
                option4.clear();
                option3.clear();
                option2.clear();
                option1.clear();
                Get.back(); // Pass the data as a result
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
    // Dispose of the TextEditingController when no longer needed
    title.dispose();
    questionText.dispose();
    option1.dispose();
    option2.dispose();
    option3.dispose();
    option4.dispose();
    correctAnswer.dispose();
    super.onClose();
  }

  answerQuestion(Question question, String selectedAnswer, double totalScore) {
    if (question.correctAnswer == selectedAnswer) {
      totalScore++;
      return totalScore;
    }
    return totalScore;
  }
}
