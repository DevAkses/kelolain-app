import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DaftarKonselingSukses extends StatelessWidget {
  const DaftarKonselingSukses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('daftar konseling sukses'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('kembali'))
          ],
        ),
      ),
    );
  }
}
