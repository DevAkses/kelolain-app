import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/quiz/controllers/quiz_controller.dart';

class ResultPage extends GetView<QuizController> {
  final String quizId;

  const ResultPage({Key? key, required this.quizId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizController quizController = Get.put(QuizController());

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Result'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Score: ${quizController.score.value}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Back to Quiz List'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
