import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/warna.dart';
import 'package:safeloan/app/widgets/button_back_leading.dart';
import '../controllers/analysis_result_controller.dart';

class AnalysisResultView extends GetView<AnalysisResultController> {
  const AnalysisResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ButtonBackLeading(),
        title: const Text(
          'Hasil Analisis',
          style: Utils.header,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Utils.biruEmpat,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.analytics,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Hasil Analisis',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F8FB),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.insights, color: Colors.black54),
                      SizedBox(width: 8.0),
                      Text(
                        'Analisis',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Bulan ini, Anda menghabiskan 30% dari total pengeluaran Anda pada kategori hiburan. Ini merupakan peningkatan 10% dibandingkan bulan lalu.',
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Icon(Icons.recommend, color: Colors.black54),
                      SizedBox(width: 8.0),
                      Text(
                        'Rekomendasi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Pertimbangkan untuk mengurangi pengeluaran hiburan sebesar 20%. Anda dapat mengalihkan dana ini ke tabungan atau investasi untuk mencapai tujuan keuangan Anda lebih cepat.',
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Cobalah mencari alternatif hiburan yang lebih ekonomis seperti kegiatan gratis atau diskon.',
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
