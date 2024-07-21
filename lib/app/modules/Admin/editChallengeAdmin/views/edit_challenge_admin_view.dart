import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safeloan/app/utils/AppColors.dart';

import '../controllers/edit_challenge_admin_controller.dart';

class EditChallengeAdminView extends GetView<EditChallengeAdminController> {
  const EditChallengeAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Challenges', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white,), onPressed: ()=> Get.back(),),
        backgroundColor: AppColors.primaryColor,
      ),
      body: const Center(
        child: Text(
          'EditChallengeAdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
