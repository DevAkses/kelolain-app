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

    final List<Widget> _pages = [
      const HomepageAdminView(),
      const QuizAdminView(),
      const EducationAdminView(),
      const ProfileAdminView(),
    ];

    return Obx(() => Scaffold(
          body: _pages[controller.selectedIndex.value],
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              controller.selectedIndex.value = index;
            },
            indicatorColor: AppColors.primaryColor,
            selectedIndex: controller.selectedIndex.value,
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.home, color: Colors.white,),
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.quiz, color: Colors.white),
                icon: Icon(Icons.quiz_outlined),
                label: 'Quiz',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.cast_for_education, color: Colors.white),
                icon: Icon(Icons.cast_for_education_outlined),
                label: 'Education',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.person, color: Colors.white),
                icon: Icon(Icons.person_outlined),
                label: 'Profile',
              ),
            ],
          
        ),
      ),
    );
  }
}
