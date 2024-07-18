import 'package:flutter/material.dart';
import 'package:safeloan/app/utils/AppColors.dart';

class PemasukanListPage extends StatelessWidget {
  const PemasukanListPage({super.key});
  Widget cardItem(String title, String deskripsi, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: ListTile(
          title: Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          subtitle:
              Text(deskripsi, style: const TextStyle(color: AppColors.abuAbu)),
          trailing: const Icon(
            Icons.arrow_upward_outlined,
            color: Colors.green,
          ),
          onTap: onTap,
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
            cardItem("Minggu 1", "Rp 100.000", () {}),
            cardItem("Minggu 1", "Rp 100.000", () {}),
            cardItem("Minggu 1", "Rp 100.000", () {}),
            cardItem("Minggu 1", "Rp 100.000", () {}),
            cardItem("Minggu 1", "Rp 100.000", () {}),
            cardItem("Minggu 1", "Rp 100.000", () {}),
            cardItem("Minggu 1", "Rp 100.000", () {}),
            cardItem("Minggu 1", "Rp 100.000", () {}),
            cardItem("Minggu 1", "Rp 100.000", () {}),
            cardItem("Minggu 1", "Rp 100.000", () {}),
            cardItem("Minggu 1", "Rp 100.000", () {}),
            cardItem("Minggu 1", "Rp 100.000", () {}),
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
