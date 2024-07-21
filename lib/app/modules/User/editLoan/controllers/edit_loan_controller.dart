import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditLoanController extends GetxController {
  late TextEditingController namaPinjamanC;
  var jumlahPinjaman = 0.obs;
  var angsuran = 0.obs;
  var bunga = 0.obs;
  var tanggalPinjaman = ''.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? loanId;

  void getLoanData() async {
    if (loanId != null) {
      DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('loans')
          .doc(loanId)
          .get();

      if (doc.exists) {
        var data = doc.data();
        if (data != null) {
          namaPinjamanC.text = data['namaPinjaman'] ?? '';
          jumlahPinjaman.value = data['jumlahPinjaman'] ?? 0;
          angsuran.value = data['angsuran'] ?? 0;
          bunga.value = data['bunga'] ?? 0;
          tanggalPinjaman.value = data['tanggalPinjaman'] ?? '';
        }
      }
    }
  }

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

  Future<bool> updateLoanData() async {
    if (loanId != null) {
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
            .doc(loanId)
            .update({
          'namaPinjaman': namaPinjamanC.text,
          'jumlahPinjaman': jumlahPinjaman.value,
          'angsuran': angsuran.value,
          'bunga': bunga.value,
          'tanggalPinjaman': tanggalPinjaman.value,
        });

        Get.snackbar('Success', 'Loan updated successfully');
        return true;
      } catch (e) {
        Get.snackbar('Error', 'Failed to update loan: $e');
        return false;
      }
    }
    return false;
  }

  @override
  void onInit() {
    namaPinjamanC = TextEditingController();
    loanId = Get.arguments as String?;
    if (loanId != null) {
      getLoanData();
    }
    super.onInit();
  }

  @override
  void dispose() {
    namaPinjamanC.dispose();
    super.dispose();
  }
}
