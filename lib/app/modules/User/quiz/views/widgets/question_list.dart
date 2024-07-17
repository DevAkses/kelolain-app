import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/quiz/controllers/quiz_controller.dart';
import 'package:safeloan/app/modules/User/quiz/views/widgets/result_page.dart';
import 'package:safeloan/app/utils/AppColors.dart';

class QuestionList extends GetView<QuizController> {
  final String quizId;

  const QuestionList({Key? key, required this.quizId}) : super(key: key);

  Widget Button(Icon icon, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.all(25),
      width: 80,
      height: 80,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.textHijauTua,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    final QuizController quizController = Get.put(QuizController());
    final PageController pageController = PageController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertanyaan'),
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
            return PageView.builder(
              controller: pageController,
              itemCount: quizController.questionList.length,
              itemBuilder: (context, index) {
                var question = quizController.questionList[index];
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            title: Container(
                              margin: EdgeInsets.only(top: 25, bottom: 25, left: 10),
                              child: Text(
                                question.pertanyaan,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...question.opsiJawaban.entries.map((entry) {
                                  return Obx(() {
                                    return Card.filled(
                                      child: ListTile(
                                        title: Center(child: Text(entry.value)),
                                        tileColor: quizController
                                                    .selectedAnswers[index] ==
                                                entry.key
                                            ? AppColors.primaryColor
                                            : null,
                                        onTap: () {
                                          quizController.selectAnswer(
                                              index, entry.key);
                                        },
                                      ),
                                    );
                                  });
                                }),
                              ],
                            ),
                          ),
                          SizedBox(height: 50,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (index > 0)
                                Button(
                                  Icon(Icons.keyboard_arrow_left,
                                      color: AppColors.textPutih),
                                  () {
                                    pageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                )
                              else
                                SizedBox(
                                    width:
                                        80), // Placeholder untuk menjaga layout

                              if (index <
                                  quizController.questionList.length - 1)
                                Button(
                                  Icon(Icons.keyboard_arrow_right,
                                      color: AppColors.textPutih),
                                  () {
                                    pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                )
                              else if (index ==
                                  quizController.questionList.length - 1)
                                Button(
                                  Icon(Icons.save, color: AppColors.textPutih),
                                  () async {
                                    await quizController.checkAnswer(quizId);
                                    Get.off(ResultPage(quizId: quizId));
                                  },
                                )
                              else
                                SizedBox(
                                    width:
                                        80), // Placeholder untuk menjaga layout
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          });
        },
      ),
    );
  }
}
