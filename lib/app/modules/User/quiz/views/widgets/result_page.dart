import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/navigation/controllers/navigation_controller.dart';
import 'package:safeloan/app/modules/User/navigation/views/navigation_view.dart';
import 'package:safeloan/app/modules/User/quiz/controllers/quiz_controller.dart';
import 'package:safeloan/app/modules/User/tab_quiz/views/tab_quiz_view.dart';
import 'package:safeloan/app/utils/warna.dart';
import 'package:safeloan/app/widgets/button_back_leading.dart';

class ResultPage extends GetView<QuizController> {
  final String quizId;

  const ResultPage({Key? key, required this.quizId}) : super(key: key);

  Widget button({required String nama,required Color backgroundColor,required VoidCallback onPressed, Color colorText = Colors.white}) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: 180,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          nama,
          style: TextStyle(
              color: colorText,
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
          title: const Text('Hasil Kuis', style: Utils.header,),
          centerTitle: true,
          leading: const ButtonBackLeading(),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  button(
                    nama :"Kembali",
                    colorText: Utils.biruSatu,
                   backgroundColor: Utils.biruLima,
                    onPressed: () => Get.offAll(
                      () => const NavigationView(),
                      binding: BindingsBuilder(
                        () {
                          Get.put(NavigationController()).changePage(2);
                        },
                      ),
                    ),
                  ),
                  button(nama: "Selanjutnya",backgroundColor :Utils.biruDua,
                      onPressed: () => Get.off(const TabQuizView())),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
