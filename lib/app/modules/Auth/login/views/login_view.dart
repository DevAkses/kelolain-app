import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/warna.dart';
import 'package:safeloan/app/widgets/button_widget.dart';
import 'package:safeloan/app/widgets/input_akun_widget.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Utils.backgroundCard,
        body: Container(
          margin: const EdgeInsets.only(top: 80),
          width: lebar,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(''),
            ],
          ),
        ),
        bottomSheet: Container(
          color: Colors.white,
          height: tinggi * 0.7,
          width: lebar,
          child: Column(
            children: [
              Container(
                height: 60,
                width: lebar,
                margin: EdgeInsets.only(left:lebar *0.1, top: 25, bottom: 20, right: lebar *0.1),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi!  👋",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Selamat datang, Masuk ke akun Anda",
                      style: Utils.subtitle,
                    ),
                  ],
                ),
              ),
              InputAkunWidget(
                controller: controller.emailC,
                hintText: "Masukan email",
                leadingIcon: Icons.email,
                nama: "Email",
              ),
              const SizedBox(
                height: 10,
              ),
              InputAkunWidget(
                controller: controller.passwordC,
                hintText: "Masukan kata sandi",
                leadingIcon: Icons.security,
                nama: "Kata sandi",
                isPassword: true,
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
                              color: Utils.biruSatu)),
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
                        fontWeight: FontWeight.w400, color: Utils.biruDua),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.REGISTER),
                    child: const Text("Daftar",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Utils.biruSatu)),
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
