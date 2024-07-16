// widgets/question_list.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/quiz/controllers/quiz_controller.dart';

class QuestionList extends GetView<QuizController> {
  final String quizId;

  const QuestionList({Key? key, required this.quizId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizController quizController = Get.put(QuizController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: quizController.getQuestionList(quizId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No questions found.'));
          }

          quizController.updateQuestionList(snapshot.data!);

          return Obx(() {
            return ListView.builder(
              itemCount: quizController.questionList.length,
              itemBuilder: (context, index) {
                var question = quizController.questionList[index];
                return ListTile(
                  title: Text(question.pertanyaan),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...question.opsiJawaban.entries.map((entry) {
                        return Obx(() {
                          return RadioListTile<String>(
                            title: Text('${entry.key}: ${entry.value}'),
                            value: entry.key,
                            groupValue: quizController.selectedAnswers[index],
                            onChanged: (value) {
                              if (value != null) {
                                quizController.selectAnswer(index, value);
                              }
                            },
                          );
                        });
                      }).toList(),
                    ],
                  ),
                );
              },
            );
          });
        },
      ),
    );
  }
}
