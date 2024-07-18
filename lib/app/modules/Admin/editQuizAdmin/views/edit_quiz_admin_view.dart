import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_quiz_admin_controller.dart';

class EditQuizAdminView extends GetView<EditQuizAdminController> {
  const EditQuizAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EditQuizAdminController controller = Get.put(EditQuizAdminController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Quiz Admin'),
        centerTitle: true,
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
            return ListTile(
              title: Text(quiz.title),
              subtitle: Text(quiz.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => Get.to(() => EditQuizView(quiz: quiz)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => controller.deleteQuiz(quiz.id),
                  ),
                ],
              ),
              onTap: () => Get.to(() => QuizDetailView(quiz: quiz)),
            );
          },
        );
      }),
    );
  }
}

class EditQuizView extends StatefulWidget {
  final Quiz quiz;

  const EditQuizView({required this.quiz, Key? key}) : super(key: key);

  @override
  _EditQuizViewState createState() => _EditQuizViewState();
}

class _EditQuizViewState extends State<EditQuizView> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final controller = Get.find<EditQuizAdminController>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.quiz.title;
    descriptionController.text = widget.quiz.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.updateQuiz(
                  widget.quiz.id,
                  titleController.text,
                  descriptionController.text,
                );
                Get.back();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}

class QuizDetailView extends StatelessWidget {
  final Quiz quiz;

  const QuizDetailView({required this.quiz, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.title),
      ),
      body: ListView.builder(
        itemCount: quiz.questions.length,
        itemBuilder: (context, index) {
          var question = quiz.questions[index];
          return ListTile(
            title: Text(question.question),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Answer: ${question.answer}'),
                Text('Explanation: ${question.explanation}'),
                Text('Options: ${question.options.toString()}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => Get.to(() =>
                      EditQuestionView(quizId: quiz.id, question: question)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EditQuestionView extends StatefulWidget {
  final String quizId;
  final Question question;

  const EditQuestionView(
      {required this.quizId, required this.question, Key? key})
      : super(key: key);

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
        title: const Text('Edit Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.updateQuestion(
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
                Get.back();
              },
              child: const Text('Save'),
            ),
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
