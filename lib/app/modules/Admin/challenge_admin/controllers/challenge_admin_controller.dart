import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengeAdminController extends GetxController {
  final challengeTitleC = TextEditingController();
  final challengeDescriptionC = TextEditingController();
  final challengePointC = TextEditingController();

  final RxString selectedCategory = ''.obs;
  final List<String> categories = [
    'article',
    'video',
    'keuangan',
  ];

  void selectCategory(String? value) {
    selectedCategory.value = value ?? '';
  }
}
