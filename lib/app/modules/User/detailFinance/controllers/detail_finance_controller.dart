import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DetailFinanceController extends GetxController {
  var financeData = <String, dynamic>{}.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxString docId = ''.obs;
  final RxString type = ''.obs; // 'income' or 'expense'

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;

    docId.value = arguments?['docId'] ?? '';
    type.value = arguments?['type'] ?? '';

    if (docId.value.isNotEmpty && type.value.isNotEmpty) {
      fetchFinanceData(docId.value, type.value);
    } else {
      Get.snackbar('Error', 'Invalid finance ID or type');
    }
  }

  void fetchFinanceData(String id, String type) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection('finances')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(type)
          .doc(id)
          .get();

      if (doc.exists) {
        financeData.value = {
          'title': doc.data()?['title'] ?? 'N/A',
          'nominal': doc.data()?['nominal'] ?? 0.0,
          'date': (doc.data()?['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
          'notes': doc.data()?['notes'] ?? 'N/A',
          'category': doc.data()?['category'] ?? 'N/A',
        };
      } else {
        Get.snackbar('Error', 'Finance data not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch finance data: $e');
    }
  }

  void updateFinanceData(String docId, String type, Map<String, dynamic> updatedData) async {
    try {
      await firestore
          .collection('finances')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(type)
          .doc(docId)
          .update(updatedData);

      Get.snackbar('Success', 'Finance data updated successfully');
      fetchFinanceData(docId, type); 
    } catch (e) {
      Get.snackbar('Error', 'Failed to update finance data: $e');
    }
  }

  void deleteFinanceData(String docId, String type) async {
    try {
      await firestore
          .collection('finances')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(type)
          .doc(docId)
          .delete();

      Get.snackbar('Success', 'Finance data deleted successfully');
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete finance data: $e');
    }
  }
}
