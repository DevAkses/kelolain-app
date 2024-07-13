import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tab_edukasi_controller.dart';

class TabEdukasiView extends GetView<TabEdukasiController> {
  const TabEdukasiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabEdukasiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TabEdukasiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
