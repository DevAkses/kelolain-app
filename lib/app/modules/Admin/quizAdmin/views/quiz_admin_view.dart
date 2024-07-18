import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/Admin/quizAdmin/controllers/quiz_admin_controller.dart';

import '../models/question_admin_model.dart';
import '../models/quiz_admin_model.dart';


class QuizAdminView extends GetView<QuizAdminController> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final List<Question> questions = List.generate(
    10,
    (index) => Question(
      id: '',
      pertanyaan: '',
      jawaban: '',
      opsiJawaban: {
        'a': 'ini salah ges',
        'b': 'yoi bener ges',
        'c': 'tau ah cape',
        'd': 'hmmmm',
      },
      penjelasan: '',
      point: 10,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Quiz'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Tambah Quiz Baru', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Judul Quiz'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi Quiz'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
                    Get.snackbar('Error', 'Judul dan Deskripsi Quiz harus diisi');
                    return;
                  }

                  Quiz newQuiz = Quiz(
                    id: '',
                    title: titleController.text,
                    description: descriptionController.text,
                  );

                  await controller.tambahQuizDanPertanyaan(newQuiz, questions);

                  titleController.clear();
                  descriptionController.clear();

                  Get.snackbar('Sukses', 'Quiz dan Pertanyaan berhasil ditambahkan');
                },
                child: const Text('Simpan Quiz dan Pertanyaan'),
              ),
              const SizedBox(height: 30),
              const Text('Tambah Pertanyaan untuk Quiz', style: TextStyle(fontSize: 20)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Pertanyaan ${index + 1}'),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Pertanyaan'),
                            onChanged: (value) {
                              questions[index].pertanyaan = value;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Jawaban'),
                            onChanged: (value) {
                              questions[index].jawaban = value;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Penjelasan'),
                            onChanged: (value) {
                              questions[index].penjelasan = value;
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ...questions[index].opsiJawaban.entries.map((entry) {
                                return Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(labelText: 'Opsi ${entry.key.toUpperCase()}'),
                                    onChanged: (value) {
                                      questions[index].opsiJawaban[entry.key] = value;
                                    },
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}