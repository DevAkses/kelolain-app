import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/quiz/models/quiz_model.dart';
import 'package:safeloan/app/modules/User/quiz/views/widgets/question_list.dart';
import 'package:safeloan/app/utils/AppColors.dart';
import 'package:safeloan/app/widgets/button_widget.dart';

class DescriptionQuizPage extends StatelessWidget {
  const DescriptionQuizPage({super.key, required this.quiz});

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Kuis Manajemen Keuangan'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset("assets/bank_icon.png", height: 100),
              ),
              const SizedBox(height: 16),
              Text(
                quiz.titleQuiz,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(quiz.deskripsiQuiz),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoColumn("10", "Soal"),
                  _buildInfoColumn("30x", "Dimainkan"),
                  _buildInfoColumn("10", "Menit"),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                "Deskripsi",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Selamat datang di Kuis Manajemen Keuangan Pribadi! Kuis ini dirancang untuk membantu Anda memahami dan mengasah keterampilan manajemen keuangan Anda. Melalui serangkaian pertanyaan interaktif, Anda akan belajar tentang konsep dasar keuangan, seperti anggaran, tabungan, investasi, dan pengelolaan utang.",
              ),
              const SizedBox(height: 25),
              Center(
                child: ButtonWidget(
                  onPressed: () {
                    Get.off(() => QuestionList(quizId: quiz.id));
                  },
                  nama: "Mulai Kuis",
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: ButtonWidget(
                  onPressed: () {},
                  nama: "Kerjakan Kuis Lain",
                  colorBackground: AppColors.primaryColor,
                  colorText: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }
}