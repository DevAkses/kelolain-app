import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DaftarKonselingController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<bool> bookSchedule(String counselingId) async {
    QuerySnapshot isHaveSchedule = await firestore
        .collection('counselings')
        .where('userId', isEqualTo: firebaseAuth.currentUser!.uid)
        .get();

    if (isHaveSchedule.docs.isNotEmpty) {
      return false;
    } else {
      await firestore
        .collection('counselings')
          .doc(counselingId)
          .update({'userId': firebaseAuth.currentUser!.uid});
      return true;
    }
  }
}
