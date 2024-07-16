import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safeloan/app/utils/AppColors.dart';

import '../controllers/challange_page_controller.dart';

class ChallangePageView extends GetView<ChallangePageController> {
  const ChallangePageView({Key? key}) : super(key: key);
  Widget CardItem(
      String title, String deskripsi, String linkGambar, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      height: 180,
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          subtitle: Text(deskripsi, style: TextStyle(color: AppColors.abuAbu)),
          trailing: Image.asset(
            linkGambar,
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [CardItem("title", "deskripsi", "linkGambar", () {})],
    );
  }
}
