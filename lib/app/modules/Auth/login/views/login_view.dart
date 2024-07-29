import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/warna.dart';
import 'package:safeloan/app/widgets/button_widget.dart';
import 'package:safeloan/app/widgets/input_akun_widget.dart';
import 'package:safeloan/app/widgets/show_dialog_info_widget.dart';
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
          margin: const EdgeInsets.only(top: 30),
          width: lebar,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
            ],
          ),
        ),
        bottomSheet: SingleChildScrollView(
          child: Container(
            height: tinggi * 0.7,
            width: lebar,
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              children: [
                Container(
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
                    onPressed: () => _validateAndSignup(context),
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
      ),
    );
  }

  void _validateAndSignup(BuildContext context) {
    if (controller.emailC.text.isEmpty ||
        controller.passwordC.text.isEmpty) {
      showDialogInfoWidget('Data Tidak Boleh Kosong', 'fail', context);
    } else {
      controller.login(
        controller.emailC.text,
        controller.passwordC.text,
        context,
      );
    }
  }
}
