import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:safeloan/app/modules/Admin/editQuizAdmin/controllers/edit_quiz_admin_controller.dart';
import 'package:safeloan/app/modules/Admin/editQuizAdmin/views/edit_question_view.dart';
import 'package:safeloan/app/utils/AppColors.dart';

class QuizDetailView extends StatelessWidget {
  final Quiz quiz;

  const QuizDetailView({required this.quiz, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white,), onPressed: ()=> Get.back(),),
        backgroundColor: AppColors.primaryColor,
      ),
      body: ListView.builder(
        itemCount: quiz.questions.length,
        itemBuilder: (context, index) {
          var question = quiz.questions[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 0.6, horizontal: 5),
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card.outlined(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: ListTile(
                title: Text(
                  question.question,
                   style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Answer: ${question.answer}'),
                    Text('Explanation: ${question.explanation}', maxLines: 2, overflow: TextOverflow.ellipsis,),
                    
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => Get.to(() =>
                      EditQuestionView(quizId: quiz.id, question: question)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}