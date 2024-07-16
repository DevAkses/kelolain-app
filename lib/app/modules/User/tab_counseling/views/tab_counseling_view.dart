import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/counseling/views/counseling_view.dart';
import 'package:safeloan/app/modules/User/daftar_konseling/views/daftar_konseling_view.dart';
import 'package:safeloan/app/utils/AppColors.dart';

import '../controllers/tab_counseling_controller.dart';

class TabCounselingView extends GetView<TabCounselingController> {
  const TabCounselingView({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Konseling Keuangan',
            style: TextStyle(
                color: AppColors.textPutih, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.textPutih,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const Text(
                "Ayo konsultasikan kondisi dan rencana finansial-mu dengan konselur keuangan yang tersedia. Jadikan finansialmu sehat sehingga terhindar dari lilitan pinjaman online beresiko!",
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: 50,
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const TabBar(
                  indicator: BoxDecoration(
                    color: Colors.green,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(text: "Jadwal Konselingku"),
                    Tab(text: "Daftar Konseling"),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  CounselingView(),
                  DaftarKonselingView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
