import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safeloan/app/modules/User/education/models/article_model.dart';
import 'package:safeloan/app/modules/User/education/views/detail_article_page.dart';

class HomepageController extends GetxController {
  var points = 60.obs;
  var currentImageIndex = 0.obs;
  late PageController pageController; // Changed to late

  var income = [1000, 1500, 1200, 1700, 1300].obs;
  var expenses = [800, 1100, 900, 1400, 1000].obs;
  var selectedFilter = 'monthly'.obs;
  var articleImages = <Article>[].obs; // Daftar artikel
  
  void startImageSlider() {
  Future.delayed(const Duration(seconds: 3), () {
    if (pageController.hasClients) {
      int nextPage = (pageController.page?.round() ?? 0) + 1;
      if (nextPage >= articleImages.length) {
        nextPage = 0;
      }
      if (pageController.hasClients) {
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    }
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
    pageController = PageController(); // Initialize pageController
    loadArticles();
  }

  @override
void onClose() {
  pageController.dispose();
  // Hentikan timer jika Anda menggunakan timer untuk slider otomatis
  super.onClose();
}

  void loadArticles() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var educationDocumentId =
        'q02NZjM7bwuOI9RDM226'; // ID dokumen pendidikan Anda
    firestore
        .collection('educations')
        .doc(educationDocumentId)
        .collection('articles')
        .snapshots()
        .listen((snapshot) {
      var articles =
          snapshot.docs.map((doc) => Article.fromDocument(doc)).toList();
      articleImages.assignAll(articles);
      startImageSlider(); // Start slider after articles are loaded
    });
  }
}
