import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safeloan/app/modules/counseling/models/counseling.dart';

class CounselingController extends GetxController {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var counselingList = <CounselingSession>[].obs;

  Stream<QuerySnapshot> getListKonseling() {
    return firestore.collection('counselings').snapshots();
  }

  void updateCounselingList(QuerySnapshot snapshot) {
    counselingList.clear();
    for (var doc in snapshot.docs) {
      counselingList.add(CounselingSession.fromDocument(doc));
    }
  }

}
