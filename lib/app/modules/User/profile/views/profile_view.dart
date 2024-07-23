import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/warna.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  Widget buildListTile({
    required IconData leadingIcon,
    required String titleText,
    String? subtitleText,
    Color leadingIconColor = Colors.black,
    Color backgroundColor = Utils.biruLima,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: backgroundColor,
          child: Icon(leadingIcon, color: leadingIconColor),
        ),
        title: Text(
          titleText,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitleText != null
            ? Text(subtitleText, style: Utils.subtitle)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: Utils.header,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 220),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 30,
                          spreadRadius: 0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Obx(
                      () => Column(
                        children: [
                          buildListTile(
                            leadingIcon: Icons.person,
                            titleText: 'Nama Lengkap',
                            subtitleText:
                                profileController.userData['fullName'],
                            leadingIconColor: Utils.biruTiga,
                          ),
                          buildListTile(
                            leadingIcon: Icons.email,
                            titleText: 'Email Address',
                            subtitleText: profileController.userData['email'],
                            leadingIconColor: Utils.biruTiga,
                          ),
                          buildListTile(
                            leadingIcon: Icons.calendar_today,
                            titleText: 'Age',
                            subtitleText:
                                profileController.userData['age'].toString(),
                            leadingIconColor: Utils.biruTiga,
                          ),
                          buildListTile(
                            leadingIcon: Icons.work,
                            titleText: 'Profession',
                            subtitleText:
                                profileController.userData['profession'],
                            leadingIconColor: Utils.biruTiga,
                          ),
                          buildListTile(
                            leadingIcon: Icons.leaderboard,
                            titleText: 'Poin',
                            subtitleText: profileController.userData['poin']
                                    ?.toString() ??
                                '0',
                            leadingIconColor: Utils.biruTiga,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(1),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 30,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () => profileController.logout(),
                    child: buildListTile(
                      leadingIcon: Icons.logout,
                      titleText: 'Keluar',
                      backgroundColor: Colors.red,
                      leadingIconColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.blueAccent.withOpacity(0.3),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          child: Obx(() {
                            final imageUrl =
                                profileController.profileImageUrl.value;
                            return CircleAvatar(
                              radius: 50,
                              backgroundImage: imageUrl.isNotEmpty
                                  ? NetworkImage(imageUrl)
                                  : null,
                              child: imageUrl.isEmpty
                                  ? Icon(Icons.person,
                                      size: 50, color: Colors.grey[200])
                                  : null,
                            );
                          }),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Utils.biruTiga,
                                  width: 2,
                                )),
                            child: IconButton(
                              onPressed: () => Get.toNamed('/edit-profile'),
                              icon: const Icon(
                                Icons.edit,
                                color: Utils.biruLima,
                              ),
                              constraints: const BoxConstraints.tightFor(
                                  width: 30, height: 30),
                              padding: EdgeInsets.zero,
                            )
                            // IconButton(
                            //   icon: const Icon(Icons.camera_alt,
                            //       color: Colors.white, size: 20),
                            //   onPressed: () =>
                            //       profileController.updateProfileImage(),
                            //   constraints: const BoxConstraints.tightFor(
                            //       width: 40, height: 40),
                            //   padding: EdgeInsets.zero,
                            // ),
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    return Column(
                      children: [
                        Text(
                          profileController.userData['fullName'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          profileController.userData['email'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
