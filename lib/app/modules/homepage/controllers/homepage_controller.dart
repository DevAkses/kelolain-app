import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomepageController extends GetxController {
  var points = 60.obs;
  var currentImageIndex = 0.obs;
  PageController pageController = PageController();

  var income = [1000, 1500, 1200, 1700, 1300].obs;
  var expenses = [800, 1100, 900, 1400, 1000].obs;
  var selectedFilter = 'monthly'.obs;

  void startImageSlider() {
    Future.delayed(Duration(seconds: 4)).then((_) {
      currentImageIndex.value =
          (currentImageIndex.value + 1) % 5; 
      pageController.animateToPage(
        currentImageIndex.value,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      startImageSlider(); 
    });
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
  }

  @override
  void onInit() {
    super.onInit();
    startImageSlider();
  }
}
