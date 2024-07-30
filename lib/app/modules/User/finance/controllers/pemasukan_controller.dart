import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PemasukanController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  FirebaseAuth get auth => _auth;

  var incomeList = <Map<String, dynamic>>[].obs;
  var totalIncome = 0.0.obs;
  var selectedFilter = 'Harian'.obs; 

  @override
  void onInit() {
    super.onInit();
    listenToIncomeData();
  }

  void listenToIncomeData() {
    String uid = _auth.currentUser!.uid;
    CollectionReference incomeCollection = _firestore
        .collection('finances')
        .doc(uid)
        .collection('income');

    incomeCollection.snapshots().listen((snapshot) {
      var incomeDocs = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        if (data['date'] is Timestamp) {
          data['date'] = (data['date'] as Timestamp).toDate();
        }
        return data;
      }).toList();
      
      incomeDocs.sort((a, b) {
        DateTime dateA = a['date'] is DateTime ? a['date'] as DateTime : DateTime.parse(a['date'].toString());
        DateTime dateB = b['date'] is DateTime ? b['date'] as DateTime : DateTime.parse(b['date'].toString());
        return dateB.compareTo(dateA); 
      });

      List<Map<String, dynamic>> filteredDocs = _filterData(incomeDocs);

      incomeList.value = filteredDocs;
      totalIncome.value = filteredDocs.fold(0.0, (sum, item) => sum + (item['nominal'] as num).toDouble());
    });
  }

  List<Map<String, dynamic>> _filterData(List<Map<String, dynamic>> data) {
    DateTime now = DateTime.now();
    DateTime startDate;

    switch (selectedFilter.value) {
      case 'Harian':
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case 'Mingguan':
        startDate = now.subtract(Duration(days: now.weekday));
        break;
      case 'Bulanan':
        startDate = DateTime(now.year, now.month);
        break;
      case 'Tahunan':
        startDate = DateTime(now.year);
        break;
      case 'Semua Data':
      default:
        return data; 
    }

    return data.where((item) {
      DateTime itemDate = item['date'] is DateTime ? item['date'] as DateTime : DateTime.parse(item['date'].toString());
      return itemDate.isAfter(startDate);
    }).toList();
  }
}
