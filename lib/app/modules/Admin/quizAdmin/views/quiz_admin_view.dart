import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/AppColors.dart';
import 'package:safeloan/app/widgets/button_widget.dart';
import '../controllers/quiz_admin_controller.dart';

class QuizAdminView extends GetView<QuizAdminController> {
  const QuizAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final questionControllers = List.generate(10, (index) => {
      'question': TextEditingController(),
      'explanation': TextEditingController(),
      'optionA': TextEditingController(),
      'optionB': TextEditingController(),
      'optionC': TextEditingController(),
      'optionD': TextEditingController(),
      'answer': TextEditingController(),
      'point': TextEditingController(text: '10'),
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Quiz'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        titleTextStyle: const TextStyle(color: AppColors.textPutih),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Create New Quiz',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textHijauTua,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Quiz Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Quiz Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...questionControllers.map((controllerMap) {
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: controllerMap['question'],
                                decoration: InputDecoration(
                                  labelText: 'Question',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: controllerMap['explanation'],
                                decoration: InputDecoration(
                                  labelText: 'Explanation',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: controllerMap['optionA'],
                                decoration: InputDecoration(
                                  labelText: 'Option A',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: controllerMap['optionB'],
                                decoration: InputDecoration(
                                  labelText: 'Option B',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: controllerMap['optionC'],
                                decoration: InputDecoration(
                                  labelText: 'Option C',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: controllerMap['optionD'],
                                decoration: InputDecoration(
                                  labelText: 'Option D',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: controllerMap['answer'],
                                decoration: InputDecoration(
                                  labelText: 'Answer',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: controllerMap['point'],
                                decoration: InputDecoration(
                                  labelText: 'Point',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                    ButtonWidget(onPressed: () {
                        final questions = questionControllers.map((controllerMap) {
                          return {
                            'pertanyaan': controllerMap['question']?.text,
                            'penjelasan': controllerMap['explanation']?.text,
                            'opsiJawaban': {
                              'a': controllerMap['optionA']?.text,
                              'b': controllerMap['optionB']?.text,
                              'c': controllerMap['optionC']?.text,
                              'd': controllerMap['optionD']?.text,
                            },
                            'jawaban': controllerMap['answer']?.text,
                            'point': int.parse(controllerMap['point']?.text ?? '10'),
                          };
                        }).toList();

                        controller.addQuiz(
                          titleController.text,
                          descriptionController.text,
                          questions,
                        );
                      }, nama: "Add Quiz")
                    // ElevatedButton(
                    //   onPressed: () {
                    //     final questions = questionControllers.map((controllerMap) {
                    //       return {
                    //         'pertanyaan': controllerMap['question']?.text,
                    //         'penjelasan': controllerMap['explanation']?.text,
                    //         'opsiJawaban': {
                    //           'a': controllerMap['optionA']?.text,
                    //           'b': controllerMap['optionB']?.text,
                    //           'c': controllerMap['optionC']?.text,
                    //           'd': controllerMap['optionD']?.text,
                    //         },
                    //         'jawaban': controllerMap['answer']?.text,
                    //         'point': int.parse(controllerMap['point']?.text ?? '10'),
                    //       };
                    //     }).toList();

                    //     controller.addQuiz(
                    //       titleController.text,
                    //       descriptionController.text,
                    //       questions,
                    //     );
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     backgroundColor: Colors.teal,
                    //   ),
                    //   child: const Text(
                    //     'Add Quiz',
                    //     style: TextStyle(fontSize: 18),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
