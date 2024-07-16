import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safeloan/app/modules/counseling/models/counseling.dart';
import 'package:safeloan/app/widgets/button_widget.dart';
import '../controllers/counseling_controller.dart';

class CounselingView extends GetView<CounselingController> {
  const CounselingView({Key? key}) : super(key: key);

  Widget CardItem(String linkGambar, String namaKonselor, String keahlian, String tanggal, String waktu,VoidCallback onPressed) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 200,
        margin: const EdgeInsets.all(20),
        child: Card(
          child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  const Text(
                    "Anda memiliki sebuah jadwal konseling, pastikan hadir tepat waktu sesuai sesi yang tersedia",
                    style: TextStyle(fontSize: 14),
                  ),
                  ListTile(
                    leading: Image.asset(linkGambar),
                    title: Text(namaKonselor),
                    subtitle: Text(keahlian),
                  ),
                  Row(children: [
                    Text("Tanggal : "),
                    Text(tanggal)
                  ],),
                  Row(children: [
                    Text("Pukul : "),
                    Text(waktu)
                  ],),
                  ButtonWidget(onPressed: onPressed, nama: "Tautan Meeting")
                ],
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CounselingController counselingController =
        Get.put(CounselingController());

    return StreamBuilder<QuerySnapshot>(
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
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: counselingController.counselingList.length,
                  itemBuilder: (context, index) {
                    CounselingSession counseling =
                        counselingController.counselingList[index];
                    return ListTile(
                      title: Text(counseling.konselorId),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Jadwal: ${DateFormat.yMMMMd().add_jm().format(counseling.jadwal)}'),
                          Text('Durasi: ${counseling.durasi}'),
                          Text('GMeet Link: ${counseling.tautanGmeet}'),
                        ],
                      ),
                      onTap: () {
                        // Handle tap
                      },
                    );
                  },
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
