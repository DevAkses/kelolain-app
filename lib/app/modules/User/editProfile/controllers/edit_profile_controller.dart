import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../detailProfile/controllers/detail_profile_controller.dart';

class EditProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var fullNameController = TextEditingController();
  var ageController = TextEditingController();
  var professionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        fullNameController.text = userDoc['fullName'] ?? '';
        ageController.text = userDoc['age']?.toString() ?? '0';
        professionController.text = userDoc['profession'] ?? '';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data');
    }
  }

  void saveProfile() async {
    try {
      String uid = _auth.currentUser!.uid;
      await _firestore.collection('users').doc(uid).update({
        'fullName': fullNameController.text,
        'age': int.parse(ageController.text),
        'profession': professionController.text,
      });

      Get.back();
      Get.snackbar('Success', 'Profile updated successfully');

      final DetailProfileController detailProfileController = Get.find<DetailProfileController>();
      detailProfileController.loadUserData();
      detailProfileController.loadProfileImage(); // Refresh profile image
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile');
    }
  }
}
