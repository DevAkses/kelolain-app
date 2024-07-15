import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/AppColors.dart';
import 'package:safeloan/app/widgets/button_widget.dart';
import 'package:safeloan/app/widgets/input_widget.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
      ),
      backgroundColor: AppColors.primaryColor,
      body: Container(
        margin: EdgeInsets.only(top: tinggi*0.05),
        width: lebar,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(''),
            const Text("Masuk"),
          ],
        ),
      ),
      bottomSheet: SizedBox(
        height: tinggi * 0.6,
        width: lebar,
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            InputWidget(
                judul: "Email",
                hint: "Masukan email",
                controller: controller.emailC),
            const SizedBox(
              height: 10,
            ),
            InputWidget(
              judul: "Password",
              controller: controller.passwordC,
              hint: "Masukan password",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: lebar * 0.1),
                  child: TextButton(
                    onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                    child: const Text("Lupa Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textHijauTua)),
                  ),
                ),
              ],
            ),
            ButtonWidget(
                onPressed: () => controller.login(
                    controller.emailC.text, controller.passwordC.text),
                nama: "Masuk"),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Belum punya akun?",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.REGISTER),
                  child: const Text("Daftar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textHijauTua)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
