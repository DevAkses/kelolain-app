import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safeloan/app/modules/Admin/educationAdmin/views/education_admin_view.dart';

import '../../homepageAdmin/views/homepage_admin_view.dart';
import '../../profileAdmin/views/profile_admin_view.dart';
import '../../quizAdmin/views/quiz_admin_view.dart';
import '../controllers/navigation_admin_controller.dart';

class NavigationAdminView extends GetView<NavigationAdminController> {
  const NavigationAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final List<Widget> _pages = [
      const HomepageAdminView(),
      QuizAdminView(),
      const EducationAdminView(),
      const ProfileAdminView(),
    ];

    return Obx(() => Scaffold(
          body: _pages[controller.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changePage,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.quiz),
                label: 'Quiz',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cast_for_education),
                label: 'Education',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ));
  }
}

