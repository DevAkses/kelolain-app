import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/AppColors.dart';
import 'package:safeloan/app/widgets/button_widget.dart';
import 'package:safeloan/app/widgets/input_akun_widget.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({super.key});

  final TextEditingController emailController = TextEditingController(text: "devaksesmikail12@gmail.com");
  final TextEditingController passwordController = TextEditingController(text: "dev123");
  final TextEditingController confirmPasswordController = TextEditingController(text: "dev123");
  final TextEditingController fullNameController = TextEditingController(text: "Dev Akses");

  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    
    String selectedRole = 'Pengguna';
    List<String> roles = ['Pengguna', 'Konselor'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: Container(
        margin: EdgeInsets.only(top: tinggi * 0.05),
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
        height: tinggi * 0.75,
        width: lebar,
        child: Column(
          children: [
            const SizedBox(height: 25),
            InputWidget(
                judul: "Nama Lengkap",
                hint: "Masukan nama lengkap",
                controller: fullNameController),
            const SizedBox(height: 10),
            InputWidget(
              judul: "Alamat Email",
              controller: emailController,
              hint: "Masukan alamat email",
            ),
            const SizedBox(height: 10),
            InputWidget(
                judul: "Kata Sandi",
                hint: "Masukan kata sandi",
                controller: passwordController),
            const SizedBox(height: 10),
            InputWidget(
              judul: "Konfirmasi Kata Sandi",
              controller: confirmPasswordController,
              hint: "Masukan konfirmasi kata sandi",
            ),
            const SizedBox(height: 15),
            DropdownButton<String>(
              value: selectedRole,
              onChanged: (String? newValue) {
                selectedRole = newValue!;
              },
              items: roles.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 15),
            ButtonWidget(
                onPressed: () {
                  controller.signup(emailController.text,
                      passwordController.text, fullNameController.text, selectedRole);
                },
                nama: "Daftar"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sudah punya akun?",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor),
                ),
                TextButton(
                  onPressed: () => Get.back(),
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
