import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/education/controllers/education_controller.dart';
import 'package:safeloan/app/modules/User/education/views/article_view.dart';
import 'package:safeloan/app/modules/User/education/views/video_view.dart';
import 'package:safeloan/app/utils/warna.dart';
import 'package:safeloan/app/widgets/button_back_leading.dart';

class EducationView extends GetView<EducationController> {
  const EducationView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edukasi',
            style: Utils.header,
          ),
          centerTitle: true,
          leading: const ButtonBackLeading()
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: const TabBar(
                  indicator: BoxDecoration(
                    color: Utils.biruTiga,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(text: "Artikel"),
                    Tab(text: "Video"),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  ArticleWidget(),
                  VideoWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
