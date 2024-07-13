import 'package:get/get.dart';

import '../controllers/list_video_page_controller.dart';

class ListVideoPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListVideoPageController>(
      () => ListVideoPageController(),
    );
  }
}
