import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../widgets/loading.dart';
import '../views/analysis_result_view.dart';

class AnalysisResultController extends GetxController {

 void showLoadingAndNavigate() async {
    try {
      Get.to(() => const LoadingView());

      await Future.delayed(const Duration(seconds: 3));

      Get.off(() => const AnalysisResultView());
    } catch (e) {
      if (kDebugMode) {
        print('Error during navigation: $e');
      }
    }
  }
}
