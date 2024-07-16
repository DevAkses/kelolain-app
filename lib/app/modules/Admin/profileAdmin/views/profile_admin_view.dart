import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_admin_controller.dart';

class ProfileAdminView extends GetView<ProfileAdminController> {
  const ProfileAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileAdminView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProfileAdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
