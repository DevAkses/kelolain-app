import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/counseling/models/counseling.dart';

class HomepageKonselorController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var counselingList = <CounselingSession>[].obs;

  Stream<QuerySnapshot> getUpcomingMeeting() {
    return firestore
    .collection('counselings')
    .where('konselorId', isEqualTo: firebaseAuth.currentUser!.uid)
    .snapshots();
  }

  void updateCounselingList(QuerySnapshot snapshot) {
    counselingList.clear();
    counselingList.addAll(snapshot.docs.where((doc) => doc['userId'] != "" && doc['userId'] != null)
        .map((doc) => CounselingSession.fromDocument(doc))
        .toList());
  }


}
