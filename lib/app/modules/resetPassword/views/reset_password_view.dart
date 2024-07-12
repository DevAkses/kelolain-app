import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              TextField(
                controller: controller.emailC,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                  onPressed: () => controller.resetPassword(
                      controller.emailC.text),
                  child: const Text("Reset Password")),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text("Sudah punya akun?"),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.LOGIN),
                    child: const Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
