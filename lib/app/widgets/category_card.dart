import 'package:flutter/material.dart';
import 'package:safeloan/app/utils/warna.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.judul,
    required this.date,
    required this.nominal,
    this.colorNominal = Colors.green,
  }) : super(key: key);

  final IconData icon;
  final String judul;
  final String date;
  final String nominal;
  final Color colorNominal;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Utils.biruEmpat,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        judul,
        style: Utils.titleStyle,
      ),
      subtitle: Text(
        date,
        style: TextStyle(fontSize: 10, color: Colors.grey),
      ),
      trailing: Text(
        'Rp $nominal',
        style: TextStyle(color: colorNominal, fontWeight: FontWeight.bold),
      ),
    );
  }
}