// widgets/quiz_list.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:safeloan/app/modules/quiz/views/widgets/question_list.dart';

class QuizList extends GetView<QuizController> {
  const QuizList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizController controller = Get.put(QuizController());

    return StreamBuilder<QuerySnapshot>(
      stream: controller.getQuizList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No quizzes found.'));
        }

        controller.updateQuizList(snapshot.data!);

        return Obx(() {
          return ListView.builder(
            itemCount: controller.quizList.length,
            itemBuilder: (context, index) {
              var quiz = controller.quizList[index];
              return ListTile(
                title: Text(quiz.titleQuiz),
                subtitle: Text(quiz.deskripsiQuiz),
                onTap: () {
                  Get.to(() => QuestionList(quizId: quiz.id));
                },
              );
            },
          );
        });
      },
    );
  }
}
