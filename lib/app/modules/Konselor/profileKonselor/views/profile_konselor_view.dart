import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_konselor_controller.dart';

class ProfileKonselorView extends GetView<ProfileKonselorController> {
  const ProfileKonselorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileKonselorView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProfileKonselorView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
