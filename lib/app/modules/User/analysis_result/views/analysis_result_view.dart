import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Image(
                  image: AssetImage('assets/images/maskot.png'),
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(width: 3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  BubbleSpecialOne(
                    text: 'Setelah menganalisis keuangan Anda, pendapatan bulanan Anda stabil, namun pengeluaran menunjukkan variasi signifikan, terutama pada kategori seperti makanan dan minuman, tagihan utilitas, dan hiburan. Tabungan Anda tumbuh stabil, sementara investasi Anda, seperti saham dan reksa dana, menghadapi fluktuasi pasar. Kewajiban terbesar berasal dari kartu kredit dan pinjaman pribadi, yang memerlukan perhatian lebih. Anda telah berhasil meningkatkan tabungan darurat, tetapi perlu mengurangi pengeluaran di kategori hiburan dan makanan dan minuman, serta mengelola utang dengan bunga tinggi. Disarankan untuk memanfaatkan aplikasi pengelolaan keuangan, mengevaluasi portofolio investasi, dan terus meningkatkan tabungan darurat untuk mencapai tujuan finansial dengan lebih efektif.',
                    isSender: false,
                    color: Utils.biruLima,
                    textStyle: TextStyle(fontSize: 14),
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
