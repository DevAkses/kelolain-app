import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safeloan/app/services/notification_manager.dart';

class AddLoanController extends GetxController {
  late TextEditingController namaPinjamanC;
  var jumlahPinjaman = 0.obs;
  var angsuran = 1.obs;
  var bunga = 0.obs;
  var tanggalPinjaman = Rxn<DateTime>();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> pickDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: tanggalPinjaman.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      tanggalPinjaman.value = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        DateTime.now().hour,
        DateTime.now().minute,
      );
    }
  }

  Future<bool> addLoan() async {
    if (namaPinjamanC.text.isEmpty ||
        jumlahPinjaman.value == 0 ||
        angsuran.value == 0 ||
        bunga.value == 0 ||
        tanggalPinjaman.value == null) {
      Get.snackbar('Error', 'All fields must be filled');
      return false;
    }

    try {
      final numberFormat = NumberFormat('#,##0', 'id_ID');
      final userId = FirebaseAuth.instance.currentUser!.uid;

      await firestore.collection('users').doc(userId).collection('loans').add({
        'namaPinjaman': namaPinjamanC.text,
        'jumlahPinjaman': jumlahPinjaman.value,
        'angsuran': angsuran.value,
        'bunga': bunga.value,
        'tanggalPinjaman': Timestamp.fromDate(tanggalPinjaman.value!),
        'createdAt': DateTime.now(),
      });

      await firestore.collection('notifications').doc().set({
        'title': namaPinjamanC.text,
        'jumlahPinjaman': jumlahPinjaman.value,
        'description':
            'Bayar Angsuran Sebesar Rp. ${numberFormat.format((jumlahPinjaman.value + (jumlahPinjaman.value * bunga.value / 100)) / angsuran.value)}',
        'tanggalPinjaman': Timestamp.fromDate(tanggalPinjaman.value!),
        'createdAt': DateTime.now(),
        'userId': userId,
      });

      // Menampilkan notifikasi setelah 5 detik pinjaman ditambahkan
      await NotificationManager().showDelayedNotification(
        userId,
        'Pinjaman Ditambahkan',
        'Pinjaman baru sebesar Rp. ${numberFormat.format(jumlahPinjaman.value)} telah berhasil ditambahkan.',
      );

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
