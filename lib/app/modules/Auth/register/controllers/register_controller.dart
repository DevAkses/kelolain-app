import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/Auth/login/views/login_view.dart';
import 'package:safeloan/app/widgets/show_dialog_info_widget.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void signup(String email, String password, String fullName, String role,
      BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'email': email,
        'role': role,
      });

      await userCredential.user!.sendEmailVerification();
      Get.offAll(const LoginView());
      showDialogInfoWidget(
          'Berhasil daftar, cek email kamu!', 'succes', context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialogInfoWidget('Password Terlalu Lemah', 'fail', context);
      } else if (e.code == 'email-already-in-use') {
        showDialogInfoWidget('Alamat Email Sudah Digunakan', 'fail', context);
      }
    } catch (e) {
      debugPrint("Error: $e");
      showDialogInfoWidget('Gagal mendaftar dengan akun ini', 'fail', context);
    }
  }
}
