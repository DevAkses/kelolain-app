import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  var profileImageUrl = RxnString();

  @override
  void onInit() {
    super.onInit();
    loadProfileImage();
  }

  void loadProfileImage() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      String? downloadUrl = userDoc.get('profileImageUrl');
      profileImageUrl.value = downloadUrl;
    } catch (e) {
      profileImageUrl.value = null;
    }
  }

  void updateProfileImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File file = File(pickedFile.path);
        String uid = FirebaseAuth.instance.currentUser!.uid;
        String filePath = 'profile_images/$uid';

        await FirebaseStorage.instance.ref(filePath).putFile(file);

        String downloadUrl = await FirebaseStorage.instance.ref(filePath).getDownloadURL();

        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'profileImageUrl': downloadUrl,
        });

        profileImageUrl.value = downloadUrl;
        Get.snackbar('Success', 'Profile picture updated successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile picture');
    }
  }

  void deleteAccount() async {
    Get.defaultDialog(
      title: "Delete Account",
      middleText: "Are you sure you want to delete your account? This action cannot be undone.",
      textCancel: "Cancel",
      textConfirm: "Delete",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        try {
          String uid = FirebaseAuth.instance.currentUser!.uid;
          await FirebaseAuth.instance.currentUser!.delete();
          await FirebaseFirestore.instance.collection('users').doc(uid).delete();
          Get.offAllNamed(Routes.LOGIN);
          Get.snackbar('Success', 'Account deleted successfully');
        } catch (e) {
          Get.snackbar('Error', 'Failed to delete account');
        }
      },
    );
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
    Get.defaultDialog(
      title: "Logout",
      middleText: "Berhasil Logout",
    );
  }
}
