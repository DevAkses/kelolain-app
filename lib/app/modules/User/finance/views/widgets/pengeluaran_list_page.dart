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
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: Utils.titleStyle),
                        const SizedBox(height: 8),
                        Text('Rp $nominal', style: Utils.subtitle),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_downward_outlined,
                      color: Colors.red,
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
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
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
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
                        'Rp. 1.200.000',
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                    items: <String>['Harian', 'Mingguan', 'Bulanan']
                        .map((String value) {
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
                    underline:
                        SizedBox(), // Hides the underline of the dropdown
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
                    "Belanja bulanan",
                    "500.000",
                    'Belanja',
                    Utils.biruDua,
                    "24 Juni 2024",
                    () {},
                  ),
                  cardItem(
                    "Makan hari ini",
                    "100.000",
                    'Makan',
                    Utils.biruDua,
                    "24 Juni 2024",
                    () {},
                  ),
                  cardItem(
                    "Kereta api",
                    "300.000",
                    'Transportasi',
                    Utils.biruDua,
                    "15 Juni 2024",
                    () {},
                  ),
                  cardItem(
                    "Bayar kos bulan Juni",
                    "300.000",
                    'Sewa',
                    Utils.biruDua,
                    "15 Juni 2024",
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
    ]);
  }
}
