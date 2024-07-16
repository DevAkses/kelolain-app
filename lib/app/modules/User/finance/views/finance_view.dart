import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/finance_controller.dart';

class FinanceView extends GetView<FinanceController> {
  const FinanceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinanceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FinanceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
