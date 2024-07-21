import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safeloan/app/utils/AppColors.dart';

import '../controllers/challange_page_controller.dart';

class ChallangePageView extends GetView<ChallangePageController> {
  ChallangePageView({super.key});
  @override
  final ChallangePageController controller = Get.put(ChallangePageController());

  Widget CardItem(
      String title, String deskripsi, IconData icon, Color iconColor) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          deskripsi,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.listChallenge(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No challenges found'));
          }
          controller.updateChallengeList(snapshot.data!);

          return Obx(() {
            return ListView.builder(
              itemCount: controller.challengeList.length,
              itemBuilder: (context, index) {
                var challenge = controller.challengeList[index];

                return FutureBuilder<bool>(
                  future: controller.isChallengeCompletedByUser(challenge.id),
                  builder: (context, completedSnapshot) {
                    if (completedSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CardItem(
                        challenge.title,
                        challenge.description,
                        Icons.hourglass_empty,
                        AppColors.abuAbu,
                      );
                    }

                    if (completedSnapshot.hasData &&
                        completedSnapshot.data == true) {
                      return CardItem(
                        challenge.title,
                        challenge.description,
                        Icons.check_circle,
                        Colors.green,
                      );
                    } else {
                      return CardItem(
                        challenge.title,
                        challenge.description,
                        Icons.history,
                        AppColors.abuAbu,
                      );
                    }
                  },
                );
              },
            );
          });
        },
      ),
    );
  }
}
