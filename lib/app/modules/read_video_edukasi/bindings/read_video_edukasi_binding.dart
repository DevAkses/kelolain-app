import 'package:get/get.dart';

import '../controllers/read_video_edukasi_controller.dart';

class ReadVideoEdukasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadVideoEdukasiController>(
      () => ReadVideoEdukasiController(),
    );
  }
}
