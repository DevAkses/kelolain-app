import 'package:get/get.dart';

class AnalysisController extends GetxController {
  final offset = 0.0.obs;
  
  @override
  void onInit() {
    super.onInit();
    animateRobot();
  }

  void animateRobot() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      offset.value = 10.0;
      await Future.delayed(const Duration(milliseconds: 500));
      offset.value = 0.0;
      return true;
    });
  }

  Future<void> createAnalisis() async {
    
  }
}

