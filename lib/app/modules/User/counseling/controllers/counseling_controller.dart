import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safeloan/app/modules/User/counseling/models/counseling.dart';

class CounselingController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var counselingList = <CounselingSession>[].obs;

  Stream<QuerySnapshot> getListKonseling() {
    return firestore.collection('counselings').snapshots();
  }

  void updateCounselingList(QuerySnapshot snapshot) {
    counselingList.clear();
    counselingList.addAll(snapshot.docs
        .map((doc) => CounselingSession.fromDocument(doc))
        .toList());
  }
}
