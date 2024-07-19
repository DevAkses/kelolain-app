import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/finance/views/widgets/pemasukan_list_page.dart';
import 'package:safeloan/app/modules/User/finance/views/widgets/pengeluaran_list_page.dart';
import 'package:safeloan/app/utils/AppColors.dart';
import '../controllers/finance_controller.dart';

class FinanceView extends GetView<FinanceController> {
  const FinanceView({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(backgroundColor: AppColors.primaryColor,),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 10),
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
                    Tab(text: "Pemasukan"),
                    Tab(text: "Pengeluaran"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TabBarView(
                  children: [
                    PemasukanListPage(),
                    PengeluaranListPage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
