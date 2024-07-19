import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class DetailProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var userData = <String, dynamic>{}.obs;
  var profileImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    loadProfileImage();
  }

  void loadUserData() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        userData.value = userDoc.data() as Map<String, dynamic>;
        if (!userData.containsKey('poinLeadherboard')) {
          userData['poinLeadherboard'] = 0;
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data');
    }
  }

  void loadProfileImage() async {
    try {
      String uid = _auth.currentUser!.uid;
      String downloadUrl = await FirebaseStorage.instance
          .ref('profile_images/$uid')
          .getDownloadURL();
      profileImageUrl.value = downloadUrl;
    } catch (e) {
      profileImageUrl.value = '';
    }
  }
}
