import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/challange_page/views/challange_page_view.dart';
import 'package:safeloan/app/modules/User/quiz/views/quiz_view.dart';
import 'package:safeloan/app/utils/AppColors.dart';

import '../controllers/tab_quiz_controller.dart';

class TabQuizView extends GetView<TabQuizController> {
  const TabQuizView({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
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
                borderRadius: BorderRadius.circular(10),
                child: const TabBar(
                  indicator: BoxDecoration(
                    color: Colors.green,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(text: "Quiz"),
                    Tab(text: "Challange"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const QuizView(),
                  ChallangePageView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
