import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CounselingController extends GetxController {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var counselingList = <Map<String, dynamic>>[].obs;

  Stream<QuerySnapshot> getListKonseling() {
    return firestore.collection('counselings').snapshots();
  }

  void updateCounselingList(QuerySnapshot snapshot) {
    counselingList.clear();
    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data['jadwal'] is Timestamp) {
        data['jadwal'] = (data['jadwal'] as Timestamp).toDate();
      }
      counselingList.add(data);
    }
  }

}
