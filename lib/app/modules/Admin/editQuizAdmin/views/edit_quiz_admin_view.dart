import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_quiz_admin_controller.dart';

class EditQuizAdminView extends GetView<EditQuizAdminController> {
  const EditQuizAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditQuizAdminView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditQuizAdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
