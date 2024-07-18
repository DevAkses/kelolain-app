import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    // Definisi warna
    const Color primaryGreen = Color(0xFF4CAF50);
    const Color lightGreen = Color(0xFFE8F5E9);
    const Color darkGreen = Color(0xFF2E7D32);
    const Color accentColor = Color(0xFFFFC107);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/backgroundprofil.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              TextButton.icon(
                onPressed: () => profileController.updateProfileImage(),
                icon: const Icon(Icons.camera_alt, color: darkGreen),
                label: const Text(
                  "Change Profile Picture",
                  style: TextStyle(color: darkGreen),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.edit, color: primaryGreen),
                title: const Text(
                  "Profile",
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  Get.toNamed('/detail-profile');
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: primaryGreen),
                title: const Text(
                  "Delete Account",
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () => profileController.deleteAccount(),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () => profileController.logout(),
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                ),
              ),
            ],
          ),
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 190,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: lightGreen,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width/2,
            right: MediaQuery.of(context).size.width/2,
            top: 100,
            child: Obx(() {
              return profileController.profileImageUrl.value != null
                  ? badges.Badge(
                      position: badges.BadgePosition.bottomEnd(),
                      badgeAnimation: const badges.BadgeAnimation.slide(),
                      badgeStyle: badges.BadgeStyle(
                        badgeColor: Colors.red,
                        padding: EdgeInsets.all(5),
                      ),
                      badgeContent: IconButton(
                        icon: const Icon(Icons.camera),
                        onPressed: () => profileController.updateProfileImage(),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            NetworkImage(profileController.profileImageUrl.value!),
                      ),
                    )
                  : badges.Badge(
                      position: badges.BadgePosition.bottomEnd(),
                      badgeAnimation: const badges.BadgeAnimation.slide(),
                      badgeStyle: badges.BadgeStyle(
                        badgeColor: Colors.red,
                        padding: EdgeInsets.all(5),
                      ),
                      badgeContent: IconButton(
                        icon: const Icon(Icons.camera),
                        onPressed: () => profileController.updateProfileImage(),
                      ),
                      child: const CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: primaryGreen,
                        ),
                      ),
                    );
            }),
          ),
        ],
      ),
    );
  }
}
