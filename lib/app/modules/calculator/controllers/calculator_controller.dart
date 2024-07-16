import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class CalculatorController extends GetxController {
  final incomeController = TextEditingController();
  final expenseController = TextEditingController();
  final loanAmountController = TextEditingController();
  final interestRateController = TextEditingController();
  final tenorController = TextEditingController();

  void calculateLoan() {
    double income = double.tryParse(incomeController.text) ?? 0;
    double expense = double.tryParse(expenseController.text) ?? 0;
    double loanAmount = double.tryParse(loanAmountController.text) ?? 0;
    double interestRate = double.tryParse(interestRateController.text) ?? 0;
    int tenor = int.tryParse(tenorController.text) ?? 0;

    if (expense > income) {
      Get.snackbar('Error', 'Pengeluaran melebihi penghasilan');
      return;
    }

    if (tenor == 0 || interestRate == 0 || loanAmount == 0) {
      Get.snackbar('Error', 'Nilai pinjaman, bunga, atau tenor tidak boleh nol');
      return;
    }

    double monthlyInterestRate = interestRate / 12 / 100;
    double monthlyInstallment = (loanAmount * monthlyInterestRate) / (1 - pow(1 + monthlyInterestRate, -tenor));
    double remainingIncome = income - expense;

    if (remainingIncome < monthlyInstallment) {
      Get.snackbar('Error', 'Penghasilan tidak cukup untuk membayar cicilan');
      return;
    }

    if (remainingIncome > (monthlyInstallment + (income * 0.1))) {
      Get.snackbar('Healthy Loan', 'Pinjaman terlihat sehat');
    } else {
      Get.snackbar('Warning', 'Pinjaman tidak sehat');
    }

    // Logika tambahan
    double totalRepayment = monthlyInstallment * tenor;
    double totalInterest = totalRepayment - loanAmount;

    if (totalInterest > loanAmount) {
      Get.snackbar('Warning', 'Total bunga lebih besar dari jumlah pinjaman');
    } else {
      Get.snackbar('Info', 'Total bunga tidak melebihi jumlah pinjaman');
    }

    if (monthlyInstallment > (income * 0.3)) {
      Get.snackbar('Warning', 'Cicilan bulanan melebihi 30% dari penghasilan bulanan');
    } else {
      Get.snackbar('Info', 'Cicilan bulanan tidak melebihi 30% dari penghasilan bulanan');
    }
  }
}
