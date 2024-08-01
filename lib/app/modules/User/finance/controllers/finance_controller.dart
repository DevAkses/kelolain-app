import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../challange_page/controllers/challange_page_controller.dart';

class FinanceController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseAuth get auth => _auth;

  final TextEditingController titleC = TextEditingController();
  final TextEditingController nominalC = TextEditingController();
  final TextEditingController dateC = TextEditingController();
  final TextEditingController notesC = TextEditingController();
  final ValueNotifier<String> selectedCategory = ValueNotifier<String>('');

  void addIncome(String title, double nominal, String category, DateTime date,
      String notes) async {
    try {
      String uid = _auth.currentUser!.uid;
      CollectionReference incomeCollection =
          _firestore.collection('finances').doc(uid).collection('income');

      DateTime updatedDate = date.add(const Duration(hours: 1));

      await incomeCollection.add({
        'title': title,
        'nominal': nominal,
        'category': category,
        'date': updatedDate,
        'notes': notes,
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (category == 'Investasi') {
        await checkAndUpdateInvestmentChallenge(uid, date);
      }

      _resetInputs();
      Get.back();
      Get.back();
      Get.back();
      Get.snackbar('Success', 'Income added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add income');
    }
  }

  Future<void> checkAndUpdateInvestmentChallenge(
      String uid, DateTime incomeDate) async {
    try {
      DateTime startOfMonth = DateTime(incomeDate.year, incomeDate.month, 1);
      DateTime endOfMonth =
          DateTime(incomeDate.year, incomeDate.month + 1, 0, 23, 59, 59);

      QuerySnapshot investmentIncomes = await _firestore
          .collection('finances')
          .doc(uid)
          .collection('income')
          .where('category', isEqualTo: 'Investasi')
          .where('date', isGreaterThanOrEqualTo: startOfMonth)
          .where('date', isLessThanOrEqualTo: endOfMonth)
          .get();

      if (investmentIncomes.docs.isNotEmpty) {
        await Get.find<ChallangePageController>()
            .checkAndCompleteFinanceChallenge(incomeDate);
      }
    } catch (e) {
      print('Error checking and updating investment challenge: $e');
    }
  }

  void confirmAddIncome(BuildContext context, String title, double nominal,
      String category, DateTime date, String notes) {
    Get.defaultDialog(
      title: "Confirm",
      middleText: "Do you want to add this income?",
      textConfirm: "Yes",
      textCancel: "No",
      onConfirm: () {
        addIncome(title, nominal, category, date, notes);
      },
      onCancel: () => Get.back(),
    );
  }

  void addExpense(String title, double nominal, String category, DateTime date,
      String notes) async {
    try {
      String uid = _auth.currentUser!.uid;
      CollectionReference expenseCollection =
          _firestore.collection('finances').doc(uid).collection('expense');

      DateTime updatedDate = date.add(const Duration(hours: 1));

      await expenseCollection.add({
        'title': title,
        'nominal': nominal,
        'category': category,
        'date': updatedDate,
        'notes': notes,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _resetInputs();
      Get.back();
      Get.back();
      Get.snackbar('Success', 'Expense added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add expense');
    }
  }

  void confirmAddExpense(BuildContext context, String title, double nominal,
      String category, DateTime date, String notes) {
    Get.defaultDialog(
      title: "Confirm",
      middleText: "Do you want to add this expense?",
      textConfirm: "Yes",
      textCancel: "No",
      onConfirm: () {
        addExpense(title, nominal, category, date, notes);
      },
      onCancel: () => Get.back(),
    );
  }

  void _resetInputs() {
    titleC.clear();
    nominalC.clear();
    dateC.clear();
    notesC.clear();
    selectedCategory.value = '';
  }
}
