import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/addFinance/views/expense_view.dart';
import 'package:safeloan/app/modules/User/addFinance/views/income_view.dart';
import '../controllers/add_finance_controller.dart';

class AddFinanceView extends GetView<AddFinanceController> {
  const AddFinanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Transaksi'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Expense'),
              Tab(text: 'Income'),
            ],
          ),
        ),
        body: const Expanded(
          child: TabBarView(
            children: [
              ExpenseView(),
              IncomeView(),
            ],
          ),
        ),
      ),
    );
  }
}
