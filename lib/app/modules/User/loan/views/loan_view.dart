import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/loan_controller.dart';

class LoanView extends GetView<LoanController> {
  const LoanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pinjaman'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Stack(
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.listLoans(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No loans available'));
                }

                var loanDocs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: loanDocs.length,
                  itemBuilder: (context, index) {
                    var loanData = loanDocs[index].data();
                    var loanId = loanDocs[index].id;

                    return GestureDetector(
                      onTap: () => Get.toNamed('/detail-loan', arguments: loanId),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    loanData['namaPinjaman'] ?? 'Pinjaman',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(FontAwesomeIcons.penToSquare, color: Colors.blue),
                                        onPressed: () => Get.toNamed('/edit-loan', arguments: loanId),
                                      ),
                                      IconButton(
                                        icon: const Icon(FontAwesomeIcons.trashCan, color: Colors.red),
                                        onPressed: () => _showDeleteConfirmationDialog(context, loanId),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(FontAwesomeIcons.moneyBillWave, color: Colors.green),
                                  const SizedBox(width: 10),
                                  Text('Rp. ${loanData['jumlahPinjaman'] ?? 0}'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(FontAwesomeIcons.percent, color: Colors.orange),
                                  const SizedBox(width: 10),
                                  Text('Bunga ${loanData['bunga'] ?? 0}%'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(FontAwesomeIcons.calendarDays, color: Colors.purple),
                                  const SizedBox(width: 10),
                                  Text('Total Angsuran: ${loanData['angsuran'] ?? 0} bulan'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Positioned(
              bottom: 20,
              right: 0,
              child: GestureDetector(
                onTap: () => Get.toNamed('/add-loan'),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String loanId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Pinjaman'),
          content: const Text('Apakah Anda yakin ingin menghapus pinjaman ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                controller.deleteLoan(loanId);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
