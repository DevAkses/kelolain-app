import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/education_controller.dart';

class EducationView extends GetView<EducationController> {
  const EducationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EducationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EducationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
