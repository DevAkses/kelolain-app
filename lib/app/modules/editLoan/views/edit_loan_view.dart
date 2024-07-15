import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_loan_controller.dart';

class EditLoanView extends GetView<EditLoanController> {
  const EditLoanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditLoanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditLoanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
