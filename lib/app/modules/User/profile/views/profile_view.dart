import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/warna.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  Widget buildListTile({
    required IconData leadingIcon,
    required String titleText,
    required IconData trailingIcon,
    required VoidCallback onTap,
    Color leadingIconColor = Colors.black,
    Color trailingIconColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Utils.biruLima,
          child: Icon(leadingIcon, color: leadingIconColor)),
        title: Text(
          titleText,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(trailingIcon, color: trailingIconColor),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 180),
              buildListTile(
                leadingIcon: Icons.person_rounded,
                leadingIconColor: Colors.blueGrey,
                titleText: "Profil Lengkap",
                trailingIcon: Icons.arrow_forward_ios,
                onTap: () {
                  Get.toNamed('/detail-profile');
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Divider(),
              ),
              buildListTile(
                leadingIcon: Icons.delete,
                leadingIconColor: Colors.red,
                titleText: "Hapus akun",
                trailingIcon: Icons.arrow_forward_ios,
                onTap: () => profileController.deleteAccount(),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red[900],
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
            top: 180,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() {
                      return Text(
                        profileController.userName.value,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      );
                    }),
                    Obx(() {
                      return Text(
                        profileController.userEmail.value,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[800]),
                      );
                    }),
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
                  color: Colors.blueGrey,
                  width: 2,
                ),
              ),
              child: Obx(() {
                final imageUrl = profileController.profileImageUrl.value;
                return CircleAvatar(
                  radius: 60,
                  backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                      ? NetworkImage(imageUrl)
                      : null,
                  child: imageUrl == null || imageUrl.isEmpty
                      ? Icon(Icons.person, size: 90, color: Colors.grey[200])
                      : null,
                );
              }),
            ),
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
                icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                onPressed: () => profileController.updateProfileImage(),
                constraints: const BoxConstraints.tightFor(width: 40, height: 40),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
