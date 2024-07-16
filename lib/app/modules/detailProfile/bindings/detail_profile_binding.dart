import 'package:get/get.dart';

import '../controllers/detail_profile_controller.dart';

class DetailProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProfileController>(
      () => DetailProfileController(),
    );
  }
}
