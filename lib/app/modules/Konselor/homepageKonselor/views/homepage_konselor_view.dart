import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/Konselor/edit_jadwal/controllers/edit_jadwal_controller.dart';
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
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 5,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.textPutih,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget CardItem(String counselingId, String linkGambar, String namaKonselor,
      String keahlian, String tanggal, String waktu, String tautanGmeet,
      VoidCallback onPressed) {
    EditJadwalController controller = Get.put(EditJadwalController());
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(linkGambar),
                ),
                title: Text(
                  namaKonselor,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(keahlian),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.event,
                      size: 16, color: AppColors.textHijauTua),
                  const SizedBox(width: 8),
                  Text(
                    "Tanggal: $tanggal",
                    style:
                        TextStyle(fontSize: 16, color: AppColors.textHijauTua),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.access_time,
                      size: 16, color: AppColors.textHijauTua),
                  const SizedBox(width: 8),
                  Text(
                    "Durasi: $waktu menit",
                    style:
                        TextStyle(fontSize: 16, color: AppColors.textHijauTua),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonKonselor('Meeting', () async {
                      String meetingUrl = tautanGmeet; // Pastikan ini adalah URL meeting yang valid
                      await controller.launchURL(meetingUrl);
                    }),
                    const SizedBox(width: 10),
                    ButtonKonselor('Selesai', () {
                      controller.deleteSchedule(counselingId);
                    }),
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
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: StreamBuilder<List<CounselingSessionWithUserData>>(
        stream: counselingController.getUpcomingMeeting(),
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

          return Obx(
            () {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView.builder(
                  itemCount: counselingController.counselingList.length,
                  itemBuilder: (context, index) {
                    CounselingSessionWithUserData session =
                        counselingController.counselingList[index];
                    String formattedDate =
                        "${session.counseling.jadwal.toLocal().toString().split(' ')[0]}";
                    String formattedDuration = "${session.counseling.durasi}";

                    return CardItem(
                      session.counseling.id,
                      "https://via.placeholder.com/150",
                      "${session.userData['fullName'] ?? 'N/A'}",
                      "${session.userData['keahlian'] ?? 'N/A'}",
                      formattedDate,
                      formattedDuration,
                      session.counseling.tautanGmeet,
                      () {
                        // Handle button press
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
