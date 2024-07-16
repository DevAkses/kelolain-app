import 'package:flutter/material.dart';
import 'package:safeloan/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailC =
      TextEditingController(text: "devaksesmikail12@gmail.com");
  TextEditingController passwordC = TextEditingController(text: "dev123");

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void login(String email, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (myUser.user!.emailVerified) {
        Get.defaultDialog(
          title: "Berhasil",
          middleText: "Anda berhasil login.",
        );
        Get.offAllNamed(Routes.NAVIGATION);
      } else {
        Get.defaultDialog(
          title: "Verification Email",
          middleText:
              "Kamu perlu verifikasi email terlebih dahulu. Apakah kamu ingin dikirimkan verifikasi ulang?",
          onConfirm: () async {
            await myUser.user!.sendEmailVerification();
            Get.back();
          },
          textConfirm: "Kirim ulang",
          textCancel: "Kembali",
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "No user found for that email.",
        );
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Email dan Password tidak sesuai. Silahkan cek kembali dengan benar.",
        );
      }
    }
  }

}
