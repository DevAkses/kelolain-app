import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/quiz/controllers/quiz_controller.dart';
import 'package:safeloan/app/modules/User/navigation/views/navigation_view.dart';
import 'package:safeloan/app/modules/User/tab_quiz/views/tab_quiz_view.dart';
import 'package:safeloan/app/utils/warna.dart';

class ResultPage extends GetView<QuizController> {
  final String quizId;

  const ResultPage({Key? key, required this.quizId}) : super(key: key);

  Widget button(
      {required String nama,
      required Color backgroundColor,
      required VoidCallback onPressed,
      Color colorText = Colors.white}) {
    return Container(
      padding: const EdgeInsets.all(15),
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
              color: colorText, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final QuizController quizController = Get.find<QuizController>();
    var tinggi = MediaQuery.of(context).size.height;

    // Fetch the quiz result when this page is built
    quizController.fetchQuizResult(quizId);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hasil Kuis',
          style: Utils.header,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              height: tinggi * 0.4,
              decoration: BoxDecoration(
                color: Utils.backgroundCard,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Nilai Anda',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    final point = quizController.quizResult['point'] ?? 0;
                    final coin = quizController.quizResult['coin'] ?? 0;
                    return Column(
                      children: [
                        Text(
                          'Point: $point',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Coin: $coin',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 50),
            button(
              nama: 'Kembali ke Beranda',
              backgroundColor: Utils.biruDua,
              onPressed: () {
                Get.offAll(() => const NavigationView());
              },
            ),
            button(
              nama: 'Coba Kuis Lain',
              backgroundColor: Colors.orange,
              onPressed: () {
                Get.off(() => const TabQuizView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
