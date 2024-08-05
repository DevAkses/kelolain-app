import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:safeloan/app/modules/User/page_toko_koin/models/transaction_model.dart';
import 'package:safeloan/app/services/transaction_service.dart';

class PageTokoKoinController extends GetxController {
  MidtransSDK? _midtrans;
  TransactionService transactionService = TransactionService();

  @override
  void onInit() {
    initSDK();
    super.onInit();
  }

  void initSDK() async {
    _midtrans = await MidtransSDK.init(
      config: MidtransConfig(
        clientKey: dotenv.env['MIDTRANS_CLIENT_KEY'] ?? "",
        merchantBaseUrl: dotenv.env['MIDTRANS_MERCHANT_BASE_URL'] ?? "",
        colorTheme: ColorTheme(
          colorPrimary: Colors.amber,
        ),
      ),
    );
    _midtrans?.setUIKitCustomSetting(
      skipCustomerDetailsPages: true,
    );
    _midtrans!.setTransactionFinishedCallback((result) {
      print(result.toJson());
    });
  }

  Future<void> startPayment() async {
    final transactionData = TransactionModel(
      orderId: 'ORDER-${DateTime.now().millisecondsSinceEpoch}',
      userId: 'test1234',
      grossAmount: 50000,
      firstName: 'ady',
      lastName: 'firdaus',
      email: 'adyfp24@gmail.com',
      phone: '873490348923',
      address: 'jalan jalan',
      itemDetails: [
        ItemDetail(
          id: '1',
          price: 50000,
          quantity: 1,
          name: 'test',
        ),
      ],
      waktuPengiriman: 'PAGI',
      createdAt: Timestamp.now(),
    );
    final response = await transactionService.createTransaction(transactionData);
    if (response['snap_token'] == null) {
      print("Snap token is null");
      return;
    }
    print("Snap token received: ${response['snap_token']}");
    await _midtrans!.startPaymentUiFlow(token: response['snap_token']);
  }

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }
}
