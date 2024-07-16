import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/navigation/controllers/navigation_controller.dart';
import 'package:safeloan/app/modules/User/navigation/views/navigation_view.dart';
import 'package:safeloan/app/modules/User/quiz/controllers/quiz_controller.dart';
import 'package:safeloan/app/modules/User/tab_quiz/views/tab_quiz_view.dart';
import 'package:safeloan/app/utils/AppColors.dart';

class ResultPage extends GetView<QuizController> {
  final String quizId;

  const ResultPage({Key? key, required this.quizId}) : super(key: key);

  Widget Button(String nama, Color color, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.all(25),
      width: 140,
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          nama,
          style: const TextStyle(
              color: AppColors.textPutih,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final QuizController quizController = Get.put(QuizController());

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Hasil Kuis'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Skor Kamu: ${quizController.score.value}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(
                    "Kembali",
                    AppColors.primaryColor,
                    () => Get.offAll(
                      () => const NavigationView(),
                      binding: BindingsBuilder(
                        () {
                          Get.put(NavigationController()).changePage(2);
                        },
                      ),
                    ),
                  ),
                  Button("Kuis Selanjutnya", AppColors.textHijauTua,
                      () => Get.off(const TabQuizView())),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
