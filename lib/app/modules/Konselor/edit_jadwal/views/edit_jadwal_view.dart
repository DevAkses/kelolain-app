import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_jadwal_controller.dart';

class EditJadwalView extends GetView<EditJadwalController> {
  const EditJadwalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditJadwalView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditJadwalView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
