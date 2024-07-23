import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/Admin/challenge_admin/views/challenge_admin_view.dart';
import 'package:safeloan/app/modules/Admin/educationAdmin/views/education_admin_view.dart';
import 'package:safeloan/app/utils/warna.dart';
import '../../homepageAdmin/views/homepage_admin_view.dart';
// import '../../profileAdmin/views/profile_admin_view.dart';
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
      const ChallengeAdminView(),
      // const ProfileAdminView(),
    ];

    return Obx(() => Scaffold(
          body: pages[controller.selectedIndex.value],
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              controller.selectedIndex.value = index;
            },
            indicatorColor: Utils.biruDua,
            selectedIndex: controller.selectedIndex.value,
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.home, color: Colors.white,),
                icon: Icon(Icons.home_outlined),
                label: 'Beranda',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.quiz, color: Colors.white),
                icon: Icon(Icons.quiz_outlined),
                label: 'Kuis',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.cast_for_education, color: Colors.white),
                icon: Icon(Icons.cast_for_education_outlined),
                label: 'Edukasi',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.flag, color: Colors.white),
                icon: Icon(Icons.flag),
                label: 'Tantangan',
              ),
              // NavigationDestination(
              //   selectedIcon: Icon(Icons.person, color: Colors.white),
              //   icon: Icon(Icons.person_outlined),
              //   label: 'Profil',
              // ),
            ],
          
        ),
      ),
    );
  }
}
