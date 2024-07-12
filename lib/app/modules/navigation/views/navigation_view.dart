import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';

class NavigationView extends GetView<NavigationController> {
  const NavigationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NavigationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NavigationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
