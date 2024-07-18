// widgets/quiz_list.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/quiz/controllers/quiz_controller.dart';
import 'package:safeloan/app/modules/User/quiz/views/widgets/description_quiz_page.dart';
import 'package:safeloan/app/utils/AppColors.dart';

class QuizList extends GetView<QuizController> {
  const QuizList({Key? key}) : super(key: key);

  Widget CardItem(
      String title, String deskripsi, String linkGambar, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: ListTile(
          title: Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          subtitle: Text(deskripsi, style: TextStyle(color: AppColors.abuAbu)),
          trailing: Image.asset(
            linkGambar,
            width: 50,
            height: 50,
          ),
          onTap: onTap,
        ),
      ),
    );
  }

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
              return CardItem(
                quiz.titleQuiz,
                quiz.deskripsiQuiz,
                '',
                () {
                  Get.off(() => DescriptionQuizPage(quiz: quiz));
                },
              );
            },
          );
        });
      },
    );
  }
}
