import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/counseling/models/counseling.dart';

class EditJadwalController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var counselingList = <CounselingSession>[].obs;

  Stream<QuerySnapshot> getAllSchedule() {
    return firestore
        .collection('counselings')
        .where('konselorId', isEqualTo: firebaseAuth.currentUser!.uid)
        .snapshots();
  }

  void updateCounselingList(QuerySnapshot snapshot) {
    counselingList.clear();
    var schedules = snapshot.docs
        .where((doc) => doc['userId'] == "" || doc['userId'] == null)
        .map((doc) => CounselingSession.fromDocument(doc))
        .toList();
    counselingList.addAll(schedules);
  }
}
