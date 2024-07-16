import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/loan_controller.dart';

class LoanView extends GetView<LoanController> {
  const LoanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LoanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
