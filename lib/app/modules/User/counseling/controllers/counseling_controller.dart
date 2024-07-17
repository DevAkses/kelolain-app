import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safeloan/app/modules/User/counseling/models/counseling.dart';

class CounselingController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var counselingList = <CounselingSession>[].obs;
  var counselingSession = Rxn<CounselingSession>();

  Stream<QuerySnapshot> getListKonseling() {
    return firestore
        .collection('counselings')
        .where('userId', isEqualTo: "")
        .snapshots();
  }

  void updateCounselingList(QuerySnapshot snapshot) {
    counselingList.clear();
    counselingList.addAll(snapshot.docs
        .map((doc) => CounselingSession.fromDocument(doc))
        .toList());
  }

  Stream<QuerySnapshot> getCounselingSession() {
    return firestore
        .collection('counselings')
        .where('userId', isEqualTo: firebaseAuth.currentUser!.uid)
        .snapshots();
  }

  void updateCounselingSession(QuerySnapshot snapshot) {
    counselingSession.value =
        CounselingSession.fromDocument(snapshot.docs.first);
  }

  void bookSchedule(String counselingId) {
    firestore
        .collection('counselings')
        .doc(counselingId)
        .update({'userId': firebaseAuth.currentUser!.uid});
  }
}
