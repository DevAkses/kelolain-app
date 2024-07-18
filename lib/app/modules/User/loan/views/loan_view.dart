import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

                    return Card(
                      elevation: 2,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(loanData['namaPinjaman'] ?? 'Pinjaman'),
                                GestureDetector(
                                  onTap: () => Get.toNamed('/edit-loan', arguments: loanDocs[index].id),
                                  child: const Text(
                                    'ubah',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text('Rp. ${loanData['jumlahPinjaman'] ?? 0}'),
                            Text('Bunga ${loanData['bunga'] ?? 0}%'),
                            Text('Total Angsuran: ${loanData['angsuran'] ?? 0}'),
                          ],
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
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
