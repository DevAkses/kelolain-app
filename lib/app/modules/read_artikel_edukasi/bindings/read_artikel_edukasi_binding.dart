import 'package:get/get.dart';

import '../controllers/read_artikel_edukasi_controller.dart';

class ReadArtikelEdukasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadArtikelEdukasiController>(
      () => ReadArtikelEdukasiController(),
    );
  }
}
