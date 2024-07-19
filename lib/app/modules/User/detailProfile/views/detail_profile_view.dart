import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_profile_controller.dart';
import 'package:safeloan/app/utils/AppColors.dart';

class DetailProfileView extends GetView<DetailProfileController> {
  const DetailProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailProfileController controller = Get.put(DetailProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Profile'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          if (controller.userData.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: [
                Center(
                  child: Obx(() {
                    return CircleAvatar(
                      radius: 60,
                      backgroundImage: controller.profileImageUrl.value.isNotEmpty
                          ? NetworkImage(controller.profileImageUrl.value)
                          : null,
                      backgroundColor: AppColors.abuAbu,
                      child: controller.profileImageUrl.value.isEmpty
                          ? Icon(Icons.person, size: 60, color: AppColors.textPutih)
                          : null,
                    );
                  }),
                ),
                const SizedBox(height: 20),
                buildProfileInfo('Full Name', controller.userData['fullName']),
                buildProfileInfo('Email', controller.userData['email']),
                buildProfileInfo('Age', controller.userData['age']),
                buildProfileInfo('Profession', controller.userData['profession']),
                buildProfileInfo('Poin Leaderboard', controller.userData['poinLeadherboard']),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => Get.toNamed('/edit-profile'),
                  child: const Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  Widget buildProfileInfo(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.textPutih,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value?.toString() ?? '',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
