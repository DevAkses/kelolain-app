import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        fullNameController.text = userDoc['fullName'];
        ageController.text = userDoc['age'].toString();
        professionController.text = userDoc['profession'];
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
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile');
    }
  }
}
