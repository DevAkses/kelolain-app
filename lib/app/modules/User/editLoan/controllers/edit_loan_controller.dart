import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditLoanController extends GetxController {
  late TextEditingController namaPinjamanC;
  late TextEditingController jumlahPinjamanC;
  late TextEditingController angsuranC;
  late TextEditingController bungaC;
  late TextEditingController pembayaranC;

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
          jumlahPinjamanC.text = data['jumlahPinjaman'].toString();
          angsuranC.text = data['angsuran'].toString();
          bungaC.text = data['bunga'].toString();
          pembayaranC.text = data['pembayaran'] ?? '';
        }
      }
    }
  }

  Future<void> updateLoanData() async {
    if (loanId != null) {
      await firestore.collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('loans')
          .doc(loanId)
          .update({
        'namaPinjaman': namaPinjamanC.text,
        'jumlahPinjaman': int.parse(jumlahPinjamanC.text),
        'angsuran': int.parse(angsuranC.text),
        'bunga': int.parse(bungaC.text),
        'pembayaran': pembayaranC.text,
      });
      Get.back();
    }
  }

  @override
  void onInit() {
    namaPinjamanC = TextEditingController();
    jumlahPinjamanC = TextEditingController();
    angsuranC = TextEditingController();
    bungaC = TextEditingController();
    pembayaranC = TextEditingController();
    loanId = Get.arguments as String?;
    if (loanId != null) {
      getLoanData();
    }
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
