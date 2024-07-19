import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/counseling/models/counseling.dart';

import '../../../../utils/AppColors.dart';
import '../controllers/homepage_konselor_controller.dart';

class HomepageKonselorView extends GetView<HomepageKonselorController> {
  const HomepageKonselorView({Key? key}) : super(key: key);
  Widget ButtonKonselor(String title, VoidCallback onPressed) {
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
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
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
                child: Row(
                  children: [
                    ButtonKonselor('Meeting', onPressed),
                    const SizedBox(
                      width:10,
                    ),
                    ButtonKonselor('Selesai', onPressed),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final HomepageKonselorController counselingController =
        Get.put(HomepageKonselorController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Meeting'),
      ),
      body: StreamBuilder(
        stream: counselingController.getUpcomingMeeting(),
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

          return Obx(
            () {
              return ListView.builder(
                itemCount: counselingController.counselingList.length,
                itemBuilder: (context, index) {
                  CounselingSession counseling =
                      counselingController.counselingList[index];
                  return CardItem(
                    "https://via.placeholder.com/150",
                    "${counseling.konselorId}",
                    "${counseling.userId}",
                    "${counseling.jadwal}",
                    "${counseling.durasi}",
                    () {},
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
