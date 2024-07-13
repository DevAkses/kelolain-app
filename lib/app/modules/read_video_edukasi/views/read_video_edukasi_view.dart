import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/read_video_edukasi_controller.dart';

class ReadVideoEdukasiView extends GetView<ReadVideoEdukasiController> {
  const ReadVideoEdukasiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReadVideoEdukasiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReadVideoEdukasiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
