import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/list_video_page_controller.dart';

class ListVideoPageView extends GetView<ListVideoPageController> {
  const ListVideoPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListVideoPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ListVideoPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
