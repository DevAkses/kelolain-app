import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safeloan/app/modules/Admin/educationAdmin/views/education_admin_view.dart';
import 'package:safeloan/app/utils/AppColors.dart';

import '../../homepageAdmin/views/homepage_admin_view.dart';
import '../../profileAdmin/views/profile_admin_view.dart';
import '../../quizAdmin/views/quiz_admin_view.dart';
import '../controllers/navigation_admin_controller.dart';

class NavigationAdminView extends GetView<NavigationAdminController> {
  const NavigationAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationAdminController controller = Get.put(NavigationAdminController());

    final List<Widget> pages = [
      const HomepageAdminView(),
      const QuizAdminView(),
      const EducationAdminView(),
      const ProfileAdminView(),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavigationBarItem(Icons.home, 'Home', 0, controller),
              _buildNavigationBarItem(Icons.quiz, 'Quiz', 1, controller),
              _buildNavigationBarItem(Icons.cast_for_education, 'Education', 2, controller),
              _buildNavigationBarItem(Icons.person, 'Profile', 3, controller),
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildNavigationBarItem(IconData icon, String label, int index, NavigationAdminController controller) {
    final isSelected = controller.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: isSelected ? BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ) : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primaryColor : Colors.white,
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {

  //   final List<Widget> _pages = [
  //     const HomepageAdminView(),
  //     QuizAdminView(),
  //     const EducationAdminView(),
  //     const ProfileAdminView(),
  //   ];

  //   return Obx(() => Scaffold(
  //         body: _pages[controller.selectedIndex.value],
  //         bottomNavigationBar: BottomNavigationBar(
  //           currentIndex: controller.selectedIndex.value,
  //           onTap: controller.changePage,
  //           selectedItemColor: Colors.blue,
  //           unselectedItemColor: Colors.grey,
  //           items: const [
  //             BottomNavigationBarItem(
  //               icon: Icon(Icons.home),
  //               label: 'Home',
  //             ),
  //             BottomNavigationBarItem(
  //               icon: Icon(Icons.quiz),
  //               label: 'Quiz',
  //             ),
  //             BottomNavigationBarItem(
  //               icon: Icon(Icons.cast_for_education),
  //               label: 'Education',
  //             ),
  //             BottomNavigationBarItem(
  //               icon: Icon(Icons.person),
  //               label: 'Profile',
  //             ),
  //           ],
  //         ),
  //       ));
  // }
}

