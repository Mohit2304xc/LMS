import 'package:dummy1/Screen/Service.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/QuestionController.dart';
import '../Model/QuestionPaperModel.dart';

class ExamPage extends StatelessWidget {
  final String examTitle;

  const ExamPage({super.key, required this.examTitle});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuestionController());
    return Scaffold(
      appBar: AppbarMenu(
        title: Text(
          '$examTitle Exam',
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        showBackArrow: true,
        onPressed: () {
          Get.back();
        },
        opacity: 1,
      ),
      body: FutureBuilder<List<Question>>(
        future: controller.fetchQuestions(examTitle),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final questions = snapshot.data!;
            return ExamScreen(
              questions: questions,
              title: examTitle,
            );
          }
        },
      ),
    );
  }
}

class ExamScreen extends StatefulWidget {
  final List<Question> questions;
  final String title;

  const ExamScreen({super.key, required this.questions, required this.title});

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  int currentQuestionIndex = 0;
  String selectedAnswer = '';
  double totalScore = 0;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuestionController());
    final service = Get.put(Service());
    if (widget.questions.isEmpty) {
      return const Center(
        child: Text('No questions available.'),
      );
    }
    final question = widget.questions[currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${currentQuestionIndex + 1}:',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(question.questionText),
          const SizedBox(height: 16),
          ...question.options.map(
            (option) => RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: selectedAnswer,
              onChanged: (value) {
                setState(
                  () {
                    selectedAnswer = value!;
                    totalScore = controller.answerQuestion(
                        question, selectedAnswer, totalScore);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (currentQuestionIndex < widget.questions.length - 1) {
                  currentQuestionIndex++;
                } else {
                  double result = totalScore / widget.questions.length * 100;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Exam Result'),
                      content: Text('Your score: $result%'),
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            final data = await service.createPDF(widget.title);
                            service.savePdfFile(
                                "${widget.title}Certificate", data);
                          },
                          child: const Center(child: Text('Continue')),
                        ),
                      ],
                    ),
                  );
                }
                print('Selected Answers: $selectedAnswer');
              });
            },
            child: Text(currentQuestionIndex < widget.questions.length - 1
                ? 'Next Question'
                : 'Finish'),
          ),
        ],
      ),
    );
  }
}
