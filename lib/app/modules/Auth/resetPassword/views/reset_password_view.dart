import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/AppColors.dart';
import 'package:safeloan/app/widgets/button_widget.dart';
import 'package:safeloan/app/widgets/input_akun_widget.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  final emailController = TextEditingController();
  ResetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Get.back(),),
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
        height: tinggi*0.6,
        width: lebar,
        child: SizedBox(
          width: lebar,
          height: tinggi / 2,
          child: Column(
            children: [
              const SizedBox(height: 25,),
              InputWidget(
                  judul: "Email",
                  hint: "Masukan email",
                  controller: emailController),
              const SizedBox(height: 15,),
              ButtonWidget(onPressed: () => (), nama: "Kirim OTP"),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum punya akun?", style: TextStyle(fontWeight: FontWeight.w400, color: AppColors.primaryColor),),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text("Masuk", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textHijauTua)),
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
