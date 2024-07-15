import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safeloan/app/modules/counseling/models/counseling.dart';
import '../controllers/counseling_controller.dart';

class CounselingView extends GetView<CounselingController> {
  const CounselingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounselingController counselingController = Get.put(CounselingController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counseling View'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: counselingController.getListKonseling(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No counseling sessions found.'));
          }
          
          counselingController.updateCounselingList(snapshot.data!);

          return Obx(() {
            return ListView.builder(
              itemCount: counselingController.counselingList.length,
              itemBuilder: (context, index) {
                CounselingSession counseling = counselingController.counselingList[index];
                return ListTile(
                  title: Text(counseling.konselorId),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jadwal: ${DateFormat.yMMMMd().add_jm().format(counseling.jadwal)}'),
                      Text('Durasi: ${counseling.durasi}'),
                      Text('GMeet Link: ${counseling.tautanGmeet}'),
                    ],
                  ),
                  onTap: () {
                    // Handle tap
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
