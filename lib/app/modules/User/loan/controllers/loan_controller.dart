import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoanController extends GetxController {
  late User? _currentuser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> listLoans() {
    return firestore
        .collection('users')
        .doc(_currentuser!.uid)
        .collection('loans')
        .snapshots();
  }

  @override
  void onInit() {
    _currentuser = FirebaseAuth.instance.currentUser;
    super.onInit();
  }
}
