import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/addFinance/views/expense_view.dart';
import 'package:safeloan/app/modules/User/addFinance/views/income_view.dart';
import 'package:safeloan/app/utils/AppColors.dart';
import '../controllers/add_finance_controller.dart';

class AddFinanceView extends GetView<AddFinanceController> {
  const AddFinanceView({super.key});

  @override
  Widget build(BuildContext context) {
    final int initialIndex = Get.arguments ?? 0;
    return DefaultTabController(
      length: 2,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tambah Transaksi',
            style: TextStyle(color: AppColors.textPutih),
          ),
          backgroundColor: AppColors.primaryColor,
          iconTheme: const IconThemeData(color: AppColors.textPutih),
          // bottom: const TabBar(
          //   labelColor: AppColors.textHijauTua,
          //   unselectedLabelColor: Colors.black,
          //   indicatorColor: AppColors.primaryColor,
          //   tabs: [
          //     Tab(text: 'Pemasukan'),
          //     Tab(text: 'Pengeluaran'),
          //   ],
          // ),
        ),
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
                    offset: const Offset(0, 3), 
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
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: TabBarView(
                  children: [
                    IncomeView(),
                    ExpenseView(),
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
