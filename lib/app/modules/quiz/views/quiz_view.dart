// views/quiz_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:safeloan/app/modules/quiz/views/widgets/quiz_list.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        centerTitle: true,
      ),
      body: QuizList(),
    );
  }
}
