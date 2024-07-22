import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/analysis/views/analysis_view.dart';
import 'package:safeloan/app/modules/User/tab_quiz/views/tab_quiz_view.dart';
import '../../finance/views/finance_view.dart';
import '../../homepage/views/homepage_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/navigation_controller.dart';

class NavigationView extends GetView<NavigationController> {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());

    final List<Widget> pages = [
      HomepageView(),
      const FinanceView(),
      const AnalysisView(),
      const TabQuizView(),
      const ProfileView(),
    ];

    return Obx(() => Scaffold(
          body: pages[controller.selectedIndex.value],
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: controller.changePage,
            selectedIndex: controller.selectedIndex.value,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: 'Beranda',
              ),
              NavigationDestination(
                icon: Icon(Icons.attach_money),
                label: 'Keuangan',
              ),
              NavigationDestination(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.quiz, color: Colors.white),
                ),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                label: 'Gamifikasi',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                label: 'Profil',
              ),
            ],
          ),
        ));
  }
}
