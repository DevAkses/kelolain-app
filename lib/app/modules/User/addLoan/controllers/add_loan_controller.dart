import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddLoanController extends GetxController {
  late TextEditingController namaPinjamanC;
  var jumlahPinjaman = 0.obs;
  var angsuran = 0.obs;
  var bunga = 0.obs;
  var tanggalPembayaran = ''.obs;

  late User? _currentuser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addLoan() async {
    CollectionReference users = firestore.collection('users');

    await users.doc(_currentuser!.uid).collection('loans').add({
      "namaPinjaman": namaPinjamanC.text,
      "jumlahPinjaman": jumlahPinjaman.value,
      "angsuran": angsuran.value,
      "bunga": bunga.value,
      "pembayaran": tanggalPembayaran.value,
    });

    // Tampilkan snackbar
    Get.snackbar(
      'Berhasil', 
      'Pinjaman Berhasil Ditambahkan',
      snackPosition: SnackPosition.BOTTOM,
    );

    // Kembali ke halaman sebelumnya  
    Get.back();
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      tanggalPembayaran.value = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  @override
  void onInit() {
    namaPinjamanC = TextEditingController();
    _currentuser = FirebaseAuth.instance.currentUser;
    super.onInit();
  }

  @override
  void dispose() {
    namaPinjamanC.dispose();
    super.dispose();
  }
}
