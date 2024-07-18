import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_admin_controller.dart';

class ProfileAdminView extends GetView<ProfileAdminController> {
  const ProfileAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ProfileAdminController controller = Get.put(ProfileAdminController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return controller.profileImageUrl.value != null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(controller.profileImageUrl.value!),
                    )
                  : const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                    );
            }),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: () => controller.updateProfileImage(),
              icon: const Icon(Icons.camera_alt),
              label: const Text("Change Profile Picture"),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Profile"),
              onTap: () {
                Get.toNamed('/detail-profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Delete Account"),
              onTap: () => controller.deleteAccount(),
            ),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () => controller.logout(),
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
