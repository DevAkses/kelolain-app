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
              TextEditingController(text: financeData['nominal']?.toString());
          final kategoriController =
              TextEditingController(text: financeData['category']);
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
                      _buildEditableCard(
                        title: 'Tanggal',
                        icon: FontAwesomeIcons.calendarDays,
                        content: financeData['date'] != null
                            ? DateFormat('dd MMMM yyyy')
                                .format(financeData['date'])
                            : 'N/A',
                      ),
                      _buildEditableCard(
                        title: 'Kategori',
                        icon: FontAwesomeIcons.tag,
                        controller: kategoriController,
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
                            kategoriController,
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
    String? content,
    TextInputType? keyboardType,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: controller != null
            ? TextField(
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(border: UnderlineInputBorder()),
              )
            : Text(content ?? 'N/A'),
      ),
    );
  }

  void _updateFinance(
      DetailFinanceController controller,
      TextEditingController titleController,
      TextEditingController jumlahController,
      TextEditingController kategoriController,
      TextEditingController deskripsiController) {
    try {
      final financeId = Get.arguments['docId'] as String;
      final type = Get.arguments['type'] as String;
      controller.updateFinanceData(financeId, type, {
        'title': titleController.text,
        'nominal': double.tryParse(jumlahController.text) ?? 0.0,
        'category': kategoriController.text,
        'notes': deskripsiController.text,
        'date': DateTime.now(),
      });
      Get.back();
      Get.back();
      Get.snackbar('Success', 'Finance data updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update finance data: $e');
    }
  }

  void _showDeleteConfirmationDialog(DetailFinanceController controller) {
    Get.defaultDialog(
      title: 'Confirm Delete',
      middleText: 'Are you sure you want to delete this finance data?',
      confirm: ElevatedButton(
        onPressed: () {
          try {
            final financeId = Get.arguments['docId'] as String;
            final type = Get.arguments['type'] as String;
            controller.deleteFinanceData(financeId, type);
          } catch (e) {
            Get.snackbar('Error', 'Failed to delete finance data: $e');
          }
        },
        child: const Text('Delete'),
      ),
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        child: const Text('Cancel'),
      ),
    );
  }
}
