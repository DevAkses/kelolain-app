import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/warna.dart';
import 'package:safeloan/app/widgets/button_widget.dart';
import 'package:safeloan/app/widgets/input_akun_widget.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    
    String selectedRole = 'Pengguna';
    List<String> roles = ['Pengguna', 'Konselor'];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
            
          ),
          backgroundColor: Utils.backgroundCard,
        ),
        backgroundColor: Utils.backgroundCard,
        body: Container(
          margin: const EdgeInsets.only(top: 20),
          width: lebar,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(''),
              const Text("Masuk"),
            ],
          ),
        ),
        bottomSheet: Container(
          color: Colors.white,
          height: tinggi * 0.75,
          width: lebar,
          child: Column(
            children: [
              Container(
                  height: 80,
                  width: lebar,
                  margin: EdgeInsets.only(left:lebar *0.1, top: 20, bottom: 20, right:lebar *0.1),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat Datang! 🙌",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Buat akun baru Anda dan mulai petualangan baru bersama kami.",
                        style: Utils.subtitle,
                      ),
                    ],
                  ),
                ),
              InputAkunWidget(controller: fullNameController, nama: "Nama lengkap", hintText: "Masukan nama lengkap", leadingIcon: Icons.person),
              const SizedBox(height: 10),
              InputAkunWidget(controller: emailController, hintText: "Masukan email", leadingIcon: Icons.email, nama: "Alamat email",),
              const SizedBox(height: 10),
              InputAkunWidget(controller: passwordController, nama: "Kata sandi", hintText: "Masukan kata sandi", leadingIcon: Icons.lock),
              const SizedBox(height: 15),
              Container(
                margin: EdgeInsets.only(right: lebar *0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                  ],
                ),
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
                        color: Utils.biruDua),
                  ),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text("Masuk",
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
