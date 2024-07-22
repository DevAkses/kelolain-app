import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddLoanController extends GetxController {
  late TextEditingController namaPinjamanC;
  var jumlahPinjaman = 0.obs;
  var angsuran = 1.obs; // Ensure minimum value is 1
  var bunga = 0.obs;
  var tanggalPinjaman = ''.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> pickDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      tanggalPinjaman.value = DateFormat('dd/MM/yyyy').format(selectedDate);
    }
  }

  Future<bool> addLoan() async {
    if (namaPinjamanC.text.isEmpty ||
        jumlahPinjaman.value == 0 ||
        angsuran.value == 0 ||
        bunga.value == 0 ||
        tanggalPinjaman.value.isEmpty) {
      Get.snackbar('Error', 'All fields must be filled');
      return false;
    }

    try {
      await firestore.collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('loans')
          .add({
        'namaPinjaman': namaPinjamanC.text,
        'jumlahPinjaman': jumlahPinjaman.value,
        'angsuran': angsuran.value,
        'bunga': bunga.value,
        'tanggalPinjaman': tanggalPinjaman.value,
        'createdAt': DateTime.now(),
      });
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to add loan: $e');
      return false;
    }
  }

  @override
  void onInit() {
    namaPinjamanC = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    namaPinjamanC.dispose();
    super.dispose();
  }
}
