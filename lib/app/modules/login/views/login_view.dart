import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/AppColors.dart';
import 'package:safeloan/app/widgets/input_widget.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      bottomSheet: SizedBox(
        height: tinggi/2,
        width: lebar,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // Align to the bottom
          children: [
            SizedBox(
              width: lebar,
              height: tinggi / 2,
              child: Column(
                children: [
                  InputWidget(
                      judul: "Email",
                      hint: "Masukan email",
                      controller: controller.emailC),
                  SizedBox(height: 10,),
                  InputWidget(
                    judul: "Password",
                    controller: controller.passwordC,
                    hint: "Masukan password",
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
          ],
        ),
      ),
    );
  }
}
