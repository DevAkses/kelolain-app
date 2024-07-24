import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/finance/views/widgets/expense_view.dart';
import 'package:safeloan/app/utils/warna.dart';

class PengeluaranListPage extends StatelessWidget {
  const PengeluaranListPage({super.key});

  Widget cardItem(String title, String nominal, String kategori,
      Color colorCategory, String tanggal, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Utils.backgroundCard,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 30,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Utils.biruSatu,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rp $nominal',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: colorCategory,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            kategori,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                        Text(
                          tanggal,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_downward_outlined,
                color: Colors.red,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Pengeluaran',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Rp. 130.000',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            spreadRadius: 0,
                            blurRadius: 30,
                            offset: const Offset(0, 5),
                          ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    items: <String>['Harian', 'Mingguan', 'Bulanan'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Add filter logic here
                    },
                    elevation: 1,
                    hint: const Text('Filter'),
                    underline: SizedBox(), // Hides the underline of the dropdown
                    isExpanded: false, // Adjust as needed
                    icon: Icon(Icons.filter_list, color: Colors.black54),
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  cardItem(
                    "Course Javascript",
                    "99.000",
                    'Pengembangan diri',
                    Utils.biruDua,
                    "20 Juli 2024",
                    () {},
                  ),
                  // Add more cardItems here
                ],
              ),
            ),
          ),
        ],
      ),
      Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Get.to(ExpenseView());
              },
              backgroundColor: Utils.biruDua,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          )
      ]
    );
  }
}
