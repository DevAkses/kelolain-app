import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safeloan/app/modules/User/education/models/article_model.dart';
import 'package:safeloan/app/modules/User/education/views/detail_article_page.dart';

class HomepageController extends GetxController {
  var points = 60.obs;
  var currentImageIndex = 0.obs;
  PageController pageController = PageController();

  var income = [1000, 1500, 1200, 1700, 1300].obs;
  var expenses = [800, 1100, 900, 1400, 1000].obs;
  var selectedFilter = 'monthly'.obs;
  var articleImages = <Article>[].obs; // Daftar artikel

  void startImageSlider() {
    Future.delayed(Duration(seconds: 4)).then((_) {
      currentImageIndex.value =
          (currentImageIndex.value + 1) % articleImages.length; 
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

  void navigateToDetailArticle(Article article) {
    Get.to(DetailArticlePage(article: article));
  }

  @override
  void onInit() {
    super.onInit();
    loadArticles();
    startImageSlider();
  }

  void loadArticles() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var educationDocumentId = 'q02NZjM7bwuOI9RDM226'; // ID dokumen pendidikan Anda
    firestore
        .collection('educations')
        .doc(educationDocumentId)
        .collection('articles')
        .snapshots()
        .listen((snapshot) {
      var articles = snapshot.docs.map((doc) => Article.fromDocument(doc)).toList();
      articleImages.assignAll(articles);
    });
  }
}
