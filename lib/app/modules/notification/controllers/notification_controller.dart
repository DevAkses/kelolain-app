import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('notifications').get();
      var data = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      notifications.value = data;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load notifications');
    }
  }
}
