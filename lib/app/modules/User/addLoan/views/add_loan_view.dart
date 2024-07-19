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
        title: const Text('AddLoanView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: controller.namaPinjamanC,
                decoration: InputDecoration(
                  labelText: 'Nama Pinjaman',
                  hintText: 'Masukkan Nama Pinjaman',
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Jumlah Pinjaman: Rp ${controller.jumlahPinjaman.value}'),
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
                  Text('Jumlah Angsuran: ${controller.angsuran.value} bulan'),
                  Slider(
                    value: controller.angsuran.value.toDouble(),
                    min: 0,
                    max: 36,
                    divisions: 12,
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
                  Text('Tanggal Pembayaran: ${controller.tanggalPembayaran.value}'),
                  ElevatedButton(
                    onPressed: () => controller.pickDate(context),
                    child: const Text('Pilih Tanggal'),
                  ),
                ],
              )),
              const SizedBox(height: 30),
              ButtonWidget(
                onPressed: () => controller.addLoan(),
                nama: 'Tambah',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
