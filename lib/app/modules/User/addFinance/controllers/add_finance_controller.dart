import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFinanceController extends GetxController {
  var nominalC = TextEditingController();
  var selectedCategory = ''.obs;

  void selectCategory(String category) {
    selectedCategory.value = category;
  }
}
