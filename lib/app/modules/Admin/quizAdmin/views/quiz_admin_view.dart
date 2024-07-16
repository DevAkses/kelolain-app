import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/quiz_admin_controller.dart';

class QuizAdminView extends GetView<QuizAdminController> {
  const QuizAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuizAdminView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'QuizAdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
