import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'package:safeloan/app/utils/AppColors.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return controller.profileImageUrl.value != null
                  ? CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(controller.profileImageUrl.value!),
                      backgroundColor: AppColors.abuAbu,
                    )
                  : CircleAvatar(
                      radius: 70,
                      backgroundColor: AppColors.abuAbu,
                      child: const Icon(Icons.person, size: 50, color: AppColors.textPutih),
                    );
            }),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: () => controller.updateProfileImage(),
              icon: const Icon(Icons.camera_alt, color: AppColors.textPutih),
              label: const Text("Change Profile Picture", style: TextStyle(color: AppColors.textPutih)),
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
              ),
            ),
            const SizedBox(height: 20),
            _buildListTile(
              icon: Icons.edit,
              title: 'Profile',
              onTap: () {
                Get.toNamed('/detail-profile');
              },
            ),
            _buildListTile(
              icon: Icons.delete,
              title: 'Delete Account',
              onTap: () => controller.deleteAccount(),
              color: Colors.red,
            ),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              ),
              onPressed: () => controller.logout(),
              icon: const Icon(Icons.logout, color: AppColors.textPutih),
              label: const Text("Logout", style: TextStyle(color: AppColors.textPutih)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({required IconData icon, required String title, required VoidCallback onTap, Color? color}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, color: color ?? AppColors.primaryColor),
        title: Text(title, style: TextStyle(color: AppColors.textHijauTua, fontWeight: FontWeight.bold)),
        onTap: onTap,
      ),
    );
  }
}
