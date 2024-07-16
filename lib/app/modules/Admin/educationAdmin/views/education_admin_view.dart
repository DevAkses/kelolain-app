import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/education_admin_controller.dart';

class EducationAdminView extends GetView<EducationAdminController> {
  const EducationAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EducationAdminView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EducationAdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
