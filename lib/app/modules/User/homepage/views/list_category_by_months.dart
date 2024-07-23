import 'package:flutter/material.dart';
import 'package:safeloan/app/widgets/category_card.dart';

class ListCategoryByMonths extends StatelessWidget {
  const ListCategoryByMonths({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Kategori Harian",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                CategoryCard(icon: Icons.money, judul: "Gaji", date: "20 June 2024", nominal: "2.000.000"),
                CategoryCard(icon: Icons.shopping_cart, judul: "Belanja", date: "21 June 2024", nominal: "500.000"),
                CategoryCard(icon: Icons.fastfood, judul: "Makan", date: "22 June 2024", nominal: "100.000"),
                // Tambahkan CategoryCard lainnya sesuai kebutuhan
              ],
            ),
          ],
        ),
      ),
    );
  }
}