import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/calculator_controller.dart';

class CalculatorView extends GetView<CalculatorController> {
  const CalculatorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CalculatorView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CalculatorView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
