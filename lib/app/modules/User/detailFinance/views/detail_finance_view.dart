import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../controllers/detail_finance_controller.dart';

class DetailFinanceView extends GetView<DetailFinanceController> {
  const DetailFinanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailFinanceController controller =
        Get.put(DetailFinanceController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Keuangan'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          final financeData = controller.financeData;

          if (financeData.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final titleController =
              TextEditingController(text: financeData['title']);
          final jumlahController =
              TextEditingController(text: financeData['nominal']?.toStringAsFixed(0));
          final deskripsiController =
              TextEditingController(text: financeData['notes']);

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      _buildEditableCard(
                        title: 'Judul',
                        icon: FontAwesomeIcons.heading,
                        controller: titleController,
                      ),
                      _buildEditableCard(
                        title: 'Jumlah',
                        icon: FontAwesomeIcons.moneyBillWave,
                        controller: jumlahController,
                        keyboardType: TextInputType.number,
                      ),
                      _buildNonEditableCard(
                        title: 'Tanggal',
                        icon: FontAwesomeIcons.calendarDays,
                        content: financeData['date'] != null
                            ? DateFormat('dd MMMM yyyy')
                                .format(financeData['date'])
                            : 'N/A',
                      ),
                      _buildNonEditableCard(
                        title: 'Kategori',
                        icon: FontAwesomeIcons.tag,
                        content: financeData['category'],
                      ),
                      _buildEditableCard(
                        title: 'Deskripsi',
                        icon: FontAwesomeIcons.infoCircle,
                        controller: deskripsiController,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _updateFinance(
                            controller,
                            titleController,
                            jumlahController,
                            deskripsiController);
                      },
                      child: const Text('Simpan'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showDeleteConfirmationDialog(controller);
                      },
                      child: const Text('Hapus'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditableCard({
    required String title,
    required IconData icon,
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(border: UnderlineInputBorder()),
        ),
      ),
    );
  }

  Widget _buildNonEditableCard({
    required String title,
    required IconData icon,
    required String content,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(content),
      ),
    );
  }

  void _updateFinance(
      DetailFinanceController controller,
      TextEditingController titleController,
      TextEditingController jumlahController,
      TextEditingController deskripsiController) {
    final jumlah = jumlahController.text;
    final nominal = double.tryParse(jumlah);

    if (nominal == null) {
      Get.snackbar('Error', 'Jumlah harus berupa angka.');
      return;
    }

    try {
      final financeId = Get.arguments['docId'] as String?;
      final type = Get.arguments['type'] as String?;

      if (financeId == null || type == null) {
        Get.snackbar('Error', 'Invalid arguments for updating finance data.');
        return;
      }

      controller.updateFinanceData(financeId, type, {
        'title': titleController.text,
        'nominal': nominal,
        'notes': deskripsiController.text,
      });
      Get.back();
      Get.back();
      Get.snackbar('Success', 'Finance data updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update finance data: $e');
    }
  }

  void _showDeleteConfirmationDialog(DetailFinanceController controller) {
    final financeId = Get.arguments['docId'] as String?;
    final type = Get.arguments['type'] as String?;

    // Debug logging
    print('Delete Confirmation: docId = $financeId, type = $type');

    if (financeId == null || type == null) {
      Get.snackbar('Error', 'Invalid arguments for deleting finance data.');
      return;
    }

    Get.defaultDialog(
      title: 'Konfirmasi Hapus',
      middleText: 'Apakah Anda yakin ingin menghapus data ini?',
      onConfirm: () {
        controller.deleteFinanceData(financeId, type);
        Get.back();
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }
}
