import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailC =
      TextEditingController(text: "devaksesmikail12@gmail.com");

  @override
  void onClose() {
    emailC.dispose();
    super.onClose();
  }
  FirebaseAuth auth = FirebaseAuth.instance;

  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
            title: "Berhasil",
            middleText:
                "Kami telah mengirimkan Reset Password ke email $email.",
            onConfirm: () {
              Get.back(); // close dialog
              Get.back(); // go to login
            },
            textConfirm: "Ya");
      } catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat mengirimkan Reset Password.",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Email tidak valid.",
      );
    }
  }
}
