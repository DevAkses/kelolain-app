import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddLoanController extends GetxController {
  late TextEditingController namaPinjamanC;
  late TextEditingController jumlahPinjamanC;
  late TextEditingController angsuranC;
  late TextEditingController bungaC;
  late TextEditingController pembayaranC;

  late User? _currentuser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addLoan () async {
    CollectionReference users = firestore.collection('users');

    await users.doc(_currentuser!.uid).collection('loans').add({
      "namaPinjaman": namaPinjamanC.text,
      "jumlahPinjaman": jumlahPinjamanC.text,
      "angsuran": angsuranC.text,
      "bunga": bungaC.text,
      "pembayaran": pembayaranC.text,
    });

    Get.snackbar('Berhasil', 'Pinjaman Berhasil Ditambahkan');
    Get.back();
  }


  @override
  void onInit() {
    namaPinjamanC = TextEditingController();
    jumlahPinjamanC = TextEditingController();
    angsuranC = TextEditingController();
    bungaC = TextEditingController();
    pembayaranC = TextEditingController();
    _currentuser = FirebaseAuth.instance.currentUser;
    super.onInit();
  }

  @override
  void dispose() {
    namaPinjamanC.dispose();
    jumlahPinjamanC.dispose();
    angsuranC.dispose();
    bungaC.dispose();
    pembayaranC.dispose();
    super.dispose();
  }
}
