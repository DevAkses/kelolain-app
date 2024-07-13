import 'package:get/get.dart';

import '../controllers/list_artikel_page_controller.dart';

class ListArtikelPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListArtikelPageController>(
      () => ListArtikelPageController(),
    );
  }
}
