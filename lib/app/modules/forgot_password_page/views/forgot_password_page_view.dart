import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_page_controller.dart';

class ForgotPasswordPageView extends GetView<ForgotPasswordPageController> {
  const ForgotPasswordPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ForgotPasswordPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ForgotPasswordPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
