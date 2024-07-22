import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:safeloan/app/modules/User/counseling/controllers/counseling_controller.dart';
import 'package:safeloan/app/modules/User/counseling/models/counseling.dart';
import 'package:safeloan/app/modules/User/daftar_konseling/views/daftar_sukses.dart';
import 'package:safeloan/app/utils/AppColors.dart';

import '../controllers/daftar_konseling_controller.dart';

class DaftarKonselingView extends GetView<DaftarKonselingController> {
  const DaftarKonselingView({Key? key}) : super(key: key);

  Widget ButtonAjukan(VoidCallback onPressed) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.textHijauTua,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: const Text(
          "Ajukan",
          style: TextStyle(
              color: AppColors.textPutih,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget CardItem(String linkGambar, String namaKonselor, String keahlian,
      String tanggal, String waktu, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  const Icon(
                    Icons.event,
                    size: 16,
                  ),
                  const Text(
                    "Tanggal: ",
                    style:
                        TextStyle(fontSize: 16, color: AppColors.textHijauTua),
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
                    style:
                        TextStyle(fontSize: 16, color: AppColors.textHijauTua),
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
        ),
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
                    CounselingSessionWithUserData session =
                        counselingController.counselingList[index];
                    return CardItem(
                        "",
                        session.userData['fullName'],
                        session.userData['profession'],
                        DateFormat.yMMMMd()
                            .add_jm()
                            .format(session.counseling.jadwal),
                        '${session.counseling.durasi}', () async {
                      bool success = await registCounseling
                          .bookSchedule(session.counseling.id);
                      if (success) {
                        Get.to(const DaftarKonselingSukses());
                      } else {
                        Get.defaultDialog(
                            title: 'Schedule Conflict',
                            middleText:
                                'You have another schedule, you can\'t book a new schedule.',
                            textConfirm: 'OK',
                            buttonColor: AppColors.primaryColor,
                            onConfirm: () => Get.back(),
                            contentPadding: const EdgeInsets.all(25));
                      }
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
