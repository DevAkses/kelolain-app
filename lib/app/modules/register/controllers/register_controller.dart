import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void signup(String email, String password, String fullName) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'email': email,
      });

      await userCredential.user!.sendEmailVerification();

      Get.defaultDialog(
        title: "Verification Email",
        middleText: "We have sent a verification email to $email",
        onConfirm: () {
          Get.back(); // Tutup dialog
          Get.back(); // Kembali ke halaman login
        },
        textConfirm: "OK",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.defaultDialog(
          title: "Error",
          middleText: "The password provided is too weak.",
        );
      } else if (e.code == 'email-already-in-use') {
        Get.defaultDialog(
          title: "Error",
          middleText: "The account already exists for that email.",
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to register with this account.",
      );
    }
  }

}
