import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/navigation_konselor_controller.dart';

class NavigationKonselorView extends GetView<NavigationKonselorController> {
  const NavigationKonselorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NavigationKonselorView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NavigationKonselorView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
