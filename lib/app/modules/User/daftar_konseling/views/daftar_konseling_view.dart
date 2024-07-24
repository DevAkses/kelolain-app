import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:safeloan/app/modules/User/counseling/controllers/counseling_controller.dart';
import 'package:safeloan/app/modules/User/counseling/models/counseling.dart';
import 'package:safeloan/app/utils/warna.dart';
import 'package:safeloan/app/widgets/confirm_show_dialog_widget.dart';
import 'package:safeloan/app/widgets/show_dialog_info_widget.dart';

import '../controllers/daftar_konseling_controller.dart';

class DaftarKonselingView extends GetView<DaftarKonselingController> {
  const DaftarKonselingView({Key? key}) : super(key: key);

  Widget ButtonAjukan(VoidCallback onPressed) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Utils.biruSatu,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: const Text(
          "Ajukan",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget CardItem(String linkGambar, String namaKonselor, String keahlian,
      String tanggal, String waktu, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Utils.backgroundCard,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(linkGambar),
            ),
            title: Text(namaKonselor,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              keahlian,
              style: Utils.subtitle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.event,
                size: 16,
              ),
              SizedBox(
                width: 5,
              ),
              const Text(
                "Tanggal: ",
                style: TextStyle(fontSize: 12, color: Utils.biruSatu),
              ),
              Text(tanggal)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.access_time,
                size: 16,
              ),
              const Text(
                " Durasi: ",
                style: TextStyle(fontSize: 12, color: Utils.biruSatu),
              ),
              Text(waktu)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ButtonAjukan(onPressed),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CounselingController counselingController =
        Get.put(CounselingController());
    final DaftarKonselingController registCounseling =
        Get.put(DaftarKonselingController());
    return StreamBuilder<List<CounselingSessionWithUserData>>(
      stream: counselingController.getListKonseling(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Tidak ada sesi konseling.'));
        }
        counselingController.updateCounselingList(snapshot.data!);
        return Obx(() {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: counselingController.counselingList.length,
                  itemBuilder: (context, index) {
                    CounselingSessionWithUserData session =
                        counselingController.counselingList[index];
                    return CardItem(
                        "",
                        session.userData['fullName'],
                        session.userData['profession'],
                        DateFormat.yMMMMd()
                            .add_jm()
                            .format(session.counseling.jadwal),
                        '${session.counseling.durasi}', () {
                      confirmShowDialog(judul: "Apakah kamu ingin ajukan sesi ini?",
                          onPressed: () async {
                        Get.back();
                        bool success = await registCounseling
                            .bookSchedule(session.counseling.id);
                        if (success) {
                          showDialogInfoWidget('Daftar konseling sukses.',
                              'succes', context);
                        } else {
                          showDialogInfoWidget(
                              "Kamu sudah memiliki jadwal konseling.",
                              'assets/images/fail.png', context);
                        }
                      },context:  context);
                    });
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
