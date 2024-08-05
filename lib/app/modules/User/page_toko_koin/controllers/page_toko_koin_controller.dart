import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:safeloan/app/modules/User/page_toko_koin/models/transaction_model.dart';
import 'package:safeloan/app/services/midtrans_service.dart';

class PageTokoKoinController extends GetxController {
  MidtransSDK? _midtrans;
  MidtransService midtransService = MidtransService();

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
            // colorPrimary: Theme.of(context).colorScheme.secondary,
            // colorPrimaryDark: Theme.of(context).colorScheme.secondary,
            // colorSecondary: Theme.of(context).colorScheme.secondary,
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
        orderId: '9089deyudhd',
        userId: 'test1234',
        grossAmount: 50000,
        firstName: 'ady',
        lastName: 'firdaus',
        email: 'adyfp242GMAIL.COM',
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
    final snapToken = await midtransService.getSnapToken(transactionData);
    if (snapToken == null) {
      return;
    }
    await _midtrans!.startPaymentUiFlow(token: snapToken);
  }

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }
}
