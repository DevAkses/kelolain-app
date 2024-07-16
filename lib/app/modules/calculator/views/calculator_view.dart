import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/calculator_controller.dart';

class CalculatorView extends GetView<CalculatorController> {
  const CalculatorView({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(controller.incomeController, 'Jumlah Penghasilan Perbulan'),
            const SizedBox(height: 10),
            _buildTextField(controller.expenseController, 'Jumlah Pengeluaran Perbulan'),
            const SizedBox(height: 10),
            _buildTextField(controller.loanAmountController, 'Jumlah Pinjaman'),
            const SizedBox(height: 10),
            _buildTextField(controller.interestRateController, 'Bunga (%)'),
            const SizedBox(height: 10),
            _buildTextField(controller.tenorController, 'Tenor (bulan)'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.calculateLoan,
              child: const Text('Kalkulasi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String placeholder) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: placeholder,
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }
}