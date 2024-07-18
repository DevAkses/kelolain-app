import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/AppColors.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
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
                  const SizedBox(height: 170),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: ListTile(
                      leading: const Icon(Icons.people,
                          color: Colors.blueGrey),
                      title: const Text(
                        "Profil Lengkap",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        Get.toNamed('/detail-profile');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 25.0),
                    child: const Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: ListTile(
                      leading: const Icon(Icons.delete,
                          color: Colors.red),
                      title: const Text(
                        "Hapus akun",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      onTap: () => profileController.updateProfileImage(),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[900],
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Nama Pengguna",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "email Pengguna",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.abuAbu,
                        width: 2,
                      ),
                    ),
                    child: Obx(() {
                      return controller.profileImageUrl.value != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                  controller.profileImageUrl.value!),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person,
                                  size: 60, color: Colors.grey[700]),
                            );
                    }),
                  )),
            ],
          ),
          Positioned(
            top: 185,
            right: 135,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                onPressed: () => controller.updateProfileImage(),
                constraints: BoxConstraints.tightFor(width: 40, height: 40),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
