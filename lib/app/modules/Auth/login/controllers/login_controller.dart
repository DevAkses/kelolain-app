import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:safeloan/app/routes/app_pages.dart';
import 'package:safeloan/app/widgets/confirm_show_dialog_widget.dart';
import 'package:safeloan/app/widgets/show_dialog_info_widget.dart';

class LoginController extends GetxController {
  TextEditingController emailC =
      TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void login(String email, String password, BuildContext context) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        showDialogInfoWidget("Email dan Password tidak boleh kosong.", 'fail', context);
        return;
      }

      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (myUser.user != null) {
        if (myUser.user!.emailVerified) {
          DocumentSnapshot userDoc =
              await firestore.collection('users').doc(myUser.user!.uid).get();
          if (userDoc.exists) {
            String? role = userDoc.get('role') as String?;
            if (role != null) {
              Get.defaultDialog(
                title: "Berhasil",
                middleText: "Anda berhasil login.",
              );
              if (role == 'Pengguna') {
                Get.offAllNamed(Routes.NAVIGATION);
              } else if (role == 'Konselor') {
                Get.offAllNamed(Routes.NAVIGATION_KONSELOR);
              } else if (role == 'Admin') {
                Get.offAllNamed(Routes.NAVIGATION_ADMIN);
              } else {
                showDialogInfoWidget("Terjadi Kesalahan.", 'fail', context);
              }
            } else {
              showDialogInfoWidget("Terjadi Kesalahan.", 'fail', context);
            }
          } else {
            showDialogInfoWidget("Data user tidak ditemukan.", 'fail', context);
          }
        } else {
          confirmShowDialog(
            judul: "Kamu perlu verifikasi email terlebih dahulu. Apakah kamu ingin dikirimkan verifikasi ulang?",
            onPressed: () async {
              await myUser.user!.sendEmailVerification();
              Get.back();
            },
            context: context,
            textBatal: "Kembali",
            textSetuju: "Kirim Ulang",
          );
        }
      } else {
        showDialogInfoWidget("Gagal login! coba lagi.", 'fail', context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
        showDialogInfoWidget("User tidak ditemukan.", 'fail', context);
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
        showDialogInfoWidget("Email dan Password salah, cek kembali data anda!.", 'fail', context);
      } else {
        showDialogInfoWidget("Email atau Kata Sandi Anda Salah", 'fail', context);
      }
    } catch (e) {
      showDialogInfoWidget("Gagal login! coba lagi.", 'fail', context);
    }
  }
}
