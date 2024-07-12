import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
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
              TextField(
                controller: controller.passwordC,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 20,
                ),
              ),
              TextButton(
                onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                child: const Text("Lupa Password"),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () => controller.login(
                      controller.emailC.text, controller.passwordC.text),
                  child: const Text("Login")),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text("Belum punya akun?"),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.REGISTER),
                    child: const Text("Daftar"),
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
