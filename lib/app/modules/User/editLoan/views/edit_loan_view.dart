import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/widgets/button_widget.dart';
import 'package:safeloan/app/widgets/input_akun_widget.dart';
import '../controllers/edit_loan_controller.dart';

class EditLoanView extends GetView<EditLoanController> {
  const EditLoanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data Pinjaman'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Column(
            children: [
              InputWidget(
                judul: 'Nama Pinjaman',
                hint: 'Masukkan Nama Pinjaman',
                controller: controller.namaPinjamanC,
              ),
              const SizedBox(height: 10),
              InputWidget(
                judul: 'Jumlah Pinjaman',
                hint: 'Masukkan Jumlah Pinjaman',
                controller: controller.jumlahPinjamanC,
              ),
              const SizedBox(height: 10),
              InputWidget(
                judul: 'Jumlah Angsuran',
                hint: 'Masukkan Jumlah Angsuran',
                controller: controller.angsuranC,
              ),
              const SizedBox(height: 10),
              InputWidget(
                judul: 'Bunga',
                hint: 'Masukkan Jumlah Bunga',
                controller: controller.bungaC,
              ),
              const SizedBox(height: 10),
              InputWidget(
                judul: 'Tanggal Pembayaran',
                hint: '15/07/2024',
                controller: controller.pembayaranC,
              ),
              const SizedBox(height: 30),
              ButtonWidget(
                onPressed: () => controller.updateLoanData(),
                nama: 'Simpan',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
