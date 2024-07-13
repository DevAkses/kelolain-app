import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/list_artikel_page_controller.dart';

class ListArtikelPageView extends GetView<ListArtikelPageController> {
  const ListArtikelPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListArtikelPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ListArtikelPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
