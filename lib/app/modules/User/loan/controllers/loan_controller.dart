import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/services/notification_service.dart';

class LoanController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> listLoans() {
    return firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('loans')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> deleteLoan(String loanId) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('loans')
        .doc(loanId)
        .delete();
    Get.back();
  }

  Future<void> showNotification() async {
    final notificationService = NotificationService();
    await notificationService.initNotification();
    notificationService.notificationsPlugin.show(
      0,
      'Judul Notifikasi',
      'Ini adalah isi notifikasi',
      notificationService.notificationDetails('channel_id'),
      payload: 'data',
    );
  }
}
