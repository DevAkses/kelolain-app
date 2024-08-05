import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:safeloan/app/modules/User/page_toko_koin/models/transaction_model.dart';

class MidtransService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['PAYMENT_API'] ?? '',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  ));

  Future<String?> getSnapToken(TransactionModel transactionData) async {
    try {
      final response = await _dio.post('/create-snap', data: transactionData.toMap());
      return response.data['token'] as String?;
    } catch (e) {
      print('Error getting Snap Token: $e');
      return null;
    }
  }
}
