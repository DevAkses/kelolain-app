import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/read_artikel_edukasi_controller.dart';

class ReadArtikelEdukasiView extends GetView<ReadArtikelEdukasiController> {
  const ReadArtikelEdukasiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReadArtikelEdukasiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReadArtikelEdukasiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
