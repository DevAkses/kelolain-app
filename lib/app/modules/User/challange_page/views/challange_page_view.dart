import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safeloan/app/utils/warna.dart';

import '../controllers/challange_page_controller.dart';

class ChallangePageView extends GetView<ChallangePageController> {
  ChallangePageView({super.key});
  @override
  final ChallangePageController controller = Get.put(ChallangePageController());

  Widget cardItem(String title, String deskripsi, IconData icon,
      Color iconColor, String imageChallenge) {
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
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 30,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: Image.network(
          imageChallenge,
          width: 50,
          height: 50,
          fit: BoxFit.fitHeight,
        ),
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: controller.challengeList.length,
                itemBuilder: (context, index) {
                  var challenge = controller.challengeList[index];
              
                  return FutureBuilder<bool>(
                    future: controller.isChallengeCompletedByUser(challenge.id),
                    builder: (context, completedSnapshot) {
                      if (completedSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return cardItem(
                          challenge.title,
                          challenge.description,
                          Icons.hourglass_empty,
                          Utils.backgroundCard,
                          challenge.imageChallenge,
                        );
                      }
              
                      if (completedSnapshot.hasData &&
                          completedSnapshot.data == true) {
                        return cardItem(
                          challenge.title,
                          challenge.description,
                          Icons.check_circle,
                          Utils.biruTiga,
                          challenge.imageChallenge,
                        );
                      } else {
                        return cardItem(
                          challenge.title,
                          challenge.description,
                          Icons.history,
                          Colors.white,
                          challenge.imageChallenge,
                        );
                      }
                    },
                  );
                },
              ),
            );
          });
        },
      ),
    );
  }
}
