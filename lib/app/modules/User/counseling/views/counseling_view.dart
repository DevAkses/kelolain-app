import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safeloan/app/utils/AppColors.dart';
import 'package:safeloan/app/widgets/button_widget.dart';
import '../controllers/counseling_controller.dart';
import '../models/counseling.dart';

class CounselingView extends GetView<CounselingController> {
  const CounselingView({Key? key}) : super(key: key);

  Widget CardItem(
    String linkGambar,
    String namaKonselor,
    String keahlian,
    String tanggal,
    String waktu,
    VoidCallback onPressed,
  ) {
    return Container(
      width: double.infinity,
      height: 280,
      margin: const EdgeInsets.all(10),
      child: Card.outlined(
        child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                const Text(
                  "Anda memiliki sebuah jadwal konseling, pastikan hadir tepat waktu sesuai sesi yang tersedia",
                  style: TextStyle(fontSize: 14),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(linkGambar),
                  ),
                  title: Text(namaKonselor),
                  subtitle: Text(keahlian),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.event,
                      size: 16,
                    ),
                    Text(
                      "Tanggal: ",
                      style: TextStyle(
                          fontSize: 16, color: AppColors.textHijauTua),
                    ),
                    Text(tanggal),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                    ),
                    Text(
                      " Durasi: ",
                      style: TextStyle(
                          fontSize: 16, color: AppColors.textHijauTua),
                    ),
                    Text(waktu),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonWidget(onPressed: onPressed, nama: "Tautan Meeting"),
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CounselingController counselingController = Get.put(CounselingController());

    return Scaffold(
      body: StreamBuilder<CounselingSessionWithUserData?>(
        stream: counselingController.getCounselingSession(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No counseling session found.'));
          }

          final session = snapshot.data!;
          final counseling = session.counseling;
          final userData = session.userData;

          return CardItem(
            userData['profileImageUrl'] ?? "", // Link gambar
            userData['fullName'] ?? 'Nama Konselor',
            userData['profession'] ?? 'Psikolog handal',
            DateFormat.yMMMMd().add_jm().format(counseling.jadwal),
            '${counseling.durasi} menit',
            () {
              // Logika untuk tautan meeting
            },
          );
        },
      ),
    );
  }
}
