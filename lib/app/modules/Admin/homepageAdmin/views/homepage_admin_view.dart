import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/homepage_admin_controller.dart';

class HomepageAdminView extends GetView<HomepageAdminController> {
  const HomepageAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomepageAdminView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomepageAdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
