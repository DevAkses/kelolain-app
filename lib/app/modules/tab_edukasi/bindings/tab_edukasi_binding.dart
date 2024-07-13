import 'package:get/get.dart';

import '../controllers/tab_edukasi_controller.dart';

class TabEdukasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabEdukasiController>(
      () => TabEdukasiController(),
    );
  }
}
