import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/analysis/controllers/analysis_controller.dart';

class AnalysisResultController extends GetxController {
  final AnalysisController analysisController = Get.put(AnalysisController());
  final RxMap<String, dynamic> analysisResult = <String, dynamic>{}.obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAnalysisResult();
  }

  Future<void> fetchAnalysisResult() async {
    try {
      isLoading.value = true;
      final result = await analysisController.createAnalisis();
      analysisResult.value = result;
    } catch (e) {
      print('Error fetching analysis result: $e');
      // Handle error (e.g., show error message)
    } finally {
      isLoading.value = false;
    }
  }

  void showLoadingAndNavigate() {
    Get.toNamed('/analysis-result');
  }
}