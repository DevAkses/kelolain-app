import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_profile_controller.dart';

class DetailProfileView extends GetView<DetailProfileController> {
  const DetailProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          if (controller.userData.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Full Name: ${controller.userData['fullName']}'),
                const SizedBox(height: 10),
                Text('Email: ${controller.userData['email']}'),
                const SizedBox(height: 10),
                Text('Age: ${controller.userData['age']}'),
                const SizedBox(height: 10),
                Text('Profession: ${controller.userData['profession']}'),
                const SizedBox(height: 10),
                Text('Poin Leadherboard: ${controller.userData['poinLeadherboard']}'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Get.toNamed('/edit-profile'),
                  child: const Text('Edit Profile'),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
