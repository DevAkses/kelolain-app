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
                      elevation: 3, // Menambahkan efek bayangan
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Sudut melengkung
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(16.0), // Padding di dalam Card
                        child: Row(
                          children: [
                            // Thumbnail image or icon
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors
                                    .green, // Warna latar belakang untuk gambar/ikon
                                borderRadius: BorderRadius.circular(
                                    30), // Sudut melengkung untuk gambar/ikon
                              ),
                              child: Icon(
                                Icons
                                    .calendar_today, // Ikon sebagai placeholder
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 16), // Jarak antara ikon dan teks
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${counseling.durasi.toString()} menit", // Format tanggal
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    counseling.jadwal.toString().split(' ')[0],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    counseling.tautanGmeet,
                                    maxLines: 1, 
                                    overflow: TextOverflow.ellipsis,
                                    
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Tindakan tombol edit dan delete
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.green),
                              onPressed: () {
                                _showEditScheduleDialog(context, counseling);
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
      title: const Text(
        'Tambah Jadwal Baru',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Tanggal Jadwal',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 16),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(
                labelText: 'Durasi (menit)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: linkController,
              decoration: const InputDecoration(
                labelText: 'Link Google Meet',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Batal',
            style: TextStyle(color: Colors.red),
          ),
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
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: const Text('Simpan', style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  },
);

}

void _showEditScheduleDialog(BuildContext context, CounselingSession schedule) {
  final EditJadwalController scheduleController =
      Get.put(EditJadwalController());
  final TextEditingController dateController =
      TextEditingController(text: schedule.jadwal.toString().split(' ')[0]);
  final TextEditingController durationController =
      TextEditingController(text: schedule.durasi.toString());
  final TextEditingController linkController =
      TextEditingController(text: schedule.tautanGmeet);

  showDialog(
  context: context,
  builder: (context) {
    return AlertDialog(
      title: const Text(
        'Edit Jadwal',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Tanggal Jadwal',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 16),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(
                labelText: 'Durasi (menit)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: linkController,
              decoration: const InputDecoration(
                labelText: 'Link Google Meet',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Batal',
            style: TextStyle(color: Colors.red),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final DateTime? jadwal = DateTime.tryParse(dateController.text);
            final int durasi = int.tryParse(durationController.text) ?? 0;
            final String tautanGmeet = linkController.text;

            if (jadwal != null) {
              scheduleController.updateSchedule(
                  schedule.id, jadwal, durasi, tautanGmeet);
              Navigator.of(context).pop();
            } else {
              Get.snackbar('Error', 'Tanggal tidak valid');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: const Text('Simpan', style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  },
);

}
