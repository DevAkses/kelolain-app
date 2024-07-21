import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/tab_quiz/views/tab_quiz_view.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:safeloan/app/utils/AppColors.dart';
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
      const TabQuizView(),
      const ProfileView(),
    ];

    return Obx(() => Scaffold(
          body: pages[controller.selectedIndex.value],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: AppColors.textHijauTua,
                  iconSize: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[300]!,
                  color: AppColors.textPutih,
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.attach_money,
                      text: 'Finance',
                    ),
                    GButton(
                      icon: Icons.quiz,
                      text: 'Quiz',
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: controller.selectedIndex.value,
                  onTabChange: (index) {
                    controller.changePage(index);
                  },
                ),
              ),
            ),
          ),
        ));
  }
}