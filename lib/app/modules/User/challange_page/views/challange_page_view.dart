import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/challange_page_controller.dart';

class ChallangePageView extends GetView<ChallangePageController> {
  ChallangePageView({super.key});
  @override
  final ChallangePageController controller = Get.put(ChallangePageController());

  Widget CardItem(String title, String deskripsi, String linkGambar) {
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (linkGambar.isNotEmpty)
              Image.network(
                linkGambar,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            const SizedBox(width: 10),
            const Icon(Icons.check_circle, color: Colors.green),
          ],
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          deskripsi,
          style: const TextStyle(color: Colors.grey),
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
          final challenges = snapshot.data!.docs;

          return ListView.builder(
            itemCount: challenges.length,
            itemBuilder: (context, index) {
              final challenge = challenges[index].data();
              final title = challenge['title'] ?? 'No title';
              final description = challenge['description'] ?? 'No description';
              final imageUrl = challenge['imageUrl'] ?? '';

              return CardItem(
                title,
                description,
                imageUrl,
              );
            },
          );
        },
      ),
    );
  }
}
