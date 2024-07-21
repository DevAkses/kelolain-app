import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:safeloan/app/modules/Admin/editQuizAdmin/controllers/edit_quiz_admin_controller.dart';
import 'package:safeloan/app/utils/AppColors.dart';
import 'package:safeloan/app/widgets/button_widget.dart';

class EditQuestionView extends StatefulWidget {
  final String quizId;
  final Question question;

  const EditQuestionView({required this.quizId, required this.question, Key? key}) : super(key: key);

  @override
  _EditQuestionViewState createState() => _EditQuestionViewState();
}

class _EditQuestionViewState extends State<EditQuestionView> {
  final questionController = TextEditingController();
  final explanationController = TextEditingController();
  final optionAController = TextEditingController();
  final optionBController = TextEditingController();
  final optionCController = TextEditingController();
  final optionDController = TextEditingController();
  final answerController = TextEditingController();
  final pointController = TextEditingController();
  final controller = Get.find<EditQuizAdminController>();

  @override
  void initState() {
    super.initState();
    questionController.text = widget.question.question;
    explanationController.text = widget.question.explanation;
    optionAController.text = widget.question.options['a'] ?? '';
    optionBController.text = widget.question.options['b'] ?? '';
    optionCController.text = widget.question.options['c'] ?? '';
    optionDController.text = widget.question.options['d'] ?? '';
    answerController.text = widget.question.answer;
    pointController.text = widget.question.point.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Question', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white,), onPressed: ()=> Get.back(),),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            TextField(
              controller: explanationController,
              decoration: const InputDecoration(labelText: 'Explanation'),
            ),
            TextField(
              controller: optionAController,
              decoration: const InputDecoration(labelText: 'Option A'),
            ),
            TextField(
              controller: optionBController,
              decoration: const InputDecoration(labelText: 'Option B'),
            ),
            TextField(
              controller: optionCController,
              decoration: const InputDecoration(labelText: 'Option C'),
            ),
            TextField(
              controller: optionDController,
              decoration: const InputDecoration(labelText: 'Option D'),
            ),
            TextField(
              controller: answerController,
              decoration: const InputDecoration(labelText: 'Answer'),
            ),
            TextField(
              controller: pointController,
              decoration: const InputDecoration(labelText: 'Point'),
              keyboardType: TextInputType.number,
            ),
            const Spacer(),
            ButtonWidget(onPressed: (){controller.updateQuestion(
                  widget.quizId,
                  widget.question.id,
                  questionController.text,
                  explanationController.text,
                  {
                    'a': optionAController.text,
                    'b': optionBController.text,
                    'c': optionCController.text,
                    'd': optionDController.text,
                  },
                  answerController.text,
                  int.parse(pointController.text),
                );
                Get.back();}, nama: "Simpan")
            
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    questionController.dispose();
    explanationController.dispose();
    optionAController.dispose();
    optionBController.dispose();
    optionCController.dispose();
    optionDController.dispose();
    answerController.dispose();
    pointController.dispose();
    super.dispose();
  }
}
