import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/widgets/button_widget.dart';
import '../controllers/add_loan_controller.dart';

class AddLoanView extends GetView<AddLoanController> {
  const AddLoanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Pinjaman'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: controller.namaPinjamanC,
                decoration: const InputDecoration(
                  labelText: 'Nama Pinjaman',
                  hintText: 'Masukkan Nama Pinjaman',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Jumlah Pinjaman: Rp ${controller.jumlahPinjaman.value}'),
                      Slider(
                        value: controller.jumlahPinjaman.value.toDouble(),
                        min: 0,
                        max: 100000000,
                        divisions: 1000,
                        label: controller.jumlahPinjaman.value.toString(),
                        onChanged: (value) {
                          controller.jumlahPinjaman.value = value.toInt();
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Jumlah Angsuran: ${controller.angsuran.value} bulan'),
                      Slider(
                        value: controller.angsuran.value.toDouble(),
                        min: 1,
                        max: 36,
                        divisions: 36,
                        label: controller.angsuran.value.toString(),
                        onChanged: (value) {
                          controller.angsuran.value = value.toInt();
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bunga: ${controller.bunga.value}%'),
                      Slider(
                        value: controller.bunga.value.toDouble(),
                        min: 0,
                        max: 25,
                        divisions: 25,
                        label: controller.bunga.value.toString(),
                        onChanged: (value) {
                          controller.bunga.value = value.toInt();
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Tanggal Pinjaman: ${controller.tanggalPinjaman.value}'),
                      InkWell(
                        onTap: () => controller.pickDate(context),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(width: 10),
                              Text('Pilih Tanggal'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 30),
              ButtonWidget(
                onPressed: () {
                  _showConfirmationDialog(context);
                },
                nama: 'Tambah',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Do you want to add this loan?'),
        actions: [
          TextButton(
            onPressed: () async {
              // Add loan and handle snackbar
              bool success = await controller.addLoan();
              if (success) {
                Get.back(); // Close the dialog
                Get.back(); // Go back to the previous page
                Get.snackbar('Success', 'Loan added successfully');
                await Future.delayed(const Duration(seconds: 1));
              }
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }
}
