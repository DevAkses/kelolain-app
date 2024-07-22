import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/Admin/editQuizAdmin/controllers/edit_quiz_admin_controller.dart';
import 'package:safeloan/app/utils/warna.dart';
import 'package:safeloan/app/widgets/button_widget.dart';

class EditQuizView extends StatefulWidget {
  final Quiz quiz;

  const EditQuizView({required this.quiz, super.key});

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
        title: const Text('Edit Quiz', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white,), onPressed: ()=> Get.back(),),
        backgroundColor: Utils.biruDua,
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
            const Spacer(),
            ButtonWidget(onPressed: (){
              controller.updateQuiz(
                  widget.quiz.id,
                  titleController.text,
                  descriptionController.text,
                );
                Get.back();
            }, nama: "Simpan")
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

