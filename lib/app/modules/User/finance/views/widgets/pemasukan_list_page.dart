import 'package:flutter/material.dart';
import 'package:safeloan/app/utils/AppColors.dart';

class PemasukanListPage extends StatelessWidget {
  const PemasukanListPage({super.key});
  Widget cardItem(String title, String nominal, String kategori,
      Color colorCategory, String tanggal, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
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
                        color: AppColors.textHijauTua,
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
                                color: AppColors.textPutih, fontSize: 12),
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
                    // const SizedBox(height: 8),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_upward_outlined,
                color: Colors.green,
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
      children: [
        ListView(
          children: [
            cardItem(
                  "Course Javascript",
                  "99.000",
                  'Pengembangan diri',
                  AppColors.primaryColor,
                  "20 Juli 2024", // Tambahkan tanggal di sini
                  () {
                // Tambahkan logika onTap di sini
                print("Card tapped");
              }),
          ],
        ),
        Positioned(
            bottom: 20,
            right: 20,
            child: SizedBox(
              height: 70,
              width: 70,
              child: CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                  color: AppColors.textPutih,
                ),
                backgroundColor: AppColors.primaryColor,
              ),
            ))
      ],
    );
  }
}
