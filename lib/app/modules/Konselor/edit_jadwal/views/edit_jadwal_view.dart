import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/counseling/models/counseling.dart';
import 'package:safeloan/app/utils/AppColors.dart';
import '../controllers/edit_jadwal_controller.dart';

class EditJadwalView extends GetView<EditJadwalController> {
  const EditJadwalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditJadwalController scheduleController =
        Get.put(EditJadwalController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Jadwal'),
      ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: scheduleController.getAllSchedule(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No schedule found.'));
              }

              scheduleController.updateCounselingList(snapshot.data!);

              return Obx(() {
                if (scheduleController.counselingList.isEmpty) {
                  return const Center(child: Text('No schedule found.'));
                }

                return ListView.builder(
                  itemCount: scheduleController.counselingList.length,
                  itemBuilder: (context, index) {
                    CounselingSession counseling =
                        scheduleController.counselingList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8.0),
                        title: Text(counseling.konselorId,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(counseling.jadwal.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                // Handle edit action
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                scheduleController
                                    .deleteSchedule(counseling.id);
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          // Handle tap action if needed
                        },
                      ),
                    );
                  },
                );
              });
            },
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                _showAddScheduleDialog(context);
              },
              backgroundColor: AppColors.textHijauTua,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddScheduleDialog(BuildContext context) {
    final EditJadwalController scheduleController =
        Get.put(EditJadwalController());
    final TextEditingController dateController = TextEditingController();
    final TextEditingController durationController = TextEditingController();
    final TextEditingController linkController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Jadwal Baru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Tanggal Jadwal'),
                keyboardType: TextInputType.datetime,
              ),
              TextField(
                controller: durationController,
                decoration: const InputDecoration(labelText: 'Durasi (menit)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: linkController,
                decoration:
                    const InputDecoration(labelText: 'Link Google Meet'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final DateTime? jadwal = DateTime.tryParse(dateController.text);
                final int durasi = int.tryParse(durationController.text) ?? 0;
                final String tautanGmeet = linkController.text;

                if (jadwal != null) {
                  scheduleController.addSchedule(jadwal, durasi, tautanGmeet);
                  Navigator.of(context).pop();
                } else {
                  Get.snackbar('Error', 'Tanggal tidak valid');
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}
