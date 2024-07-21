import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/Admin/editQuizAdmin/views/detail_quiz.dart';
import 'package:safeloan/app/modules/Admin/editQuizAdmin/views/edit_quiz_detail.dart';
import 'package:safeloan/app/utils/AppColors.dart';
import '../controllers/edit_quiz_admin_controller.dart';

class ListQuizAdminView extends GetView<EditQuizAdminController> {
  const ListQuizAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EditQuizAdminController controller = Get.put(EditQuizAdminController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Quiz', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Obx(() {
        if (controller.quizzes.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: controller.quizzes.length,
          itemBuilder: (context, index) {
            var quiz = controller.quizzes[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 0.6, horizontal: 5),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Card.outlined(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: ListTile(
                  title: Text(
                    quiz.title,
                     style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                  ),
                  subtitle: Text(
                    quiz.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => Get.to(() => EditQuizView(quiz: quiz)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => controller.deleteQuiz(quiz.id),
                      ),
                    ],
                  ),
                  onTap: () => Get.to(() => QuizDetailView(quiz: quiz)),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
