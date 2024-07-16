import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/education/controllers/education_controller.dart';
import 'package:safeloan/app/modules/User/education/views/article_view.dart';
import 'package:safeloan/app/modules/User/education/views/video_view.dart';

class EducationView extends GetView<EducationController> {
  const EducationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Education'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Articles'),
              Tab(text: 'Videos'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ArticleWidget(),
            VideoWidget(),
          ],
        ),
      ),
    );
  }
}
