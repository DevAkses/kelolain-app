import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/navigation_admin_controller.dart';

class NavigationAdminView extends GetView<NavigationAdminController> {
  const NavigationAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NavigationAdminView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NavigationAdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
