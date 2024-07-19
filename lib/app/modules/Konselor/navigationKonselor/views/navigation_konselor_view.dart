import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:safeloan/app/modules/Konselor/edit_jadwal/views/edit_jadwal_view.dart';

import '../../homepageKonselor/views/homepage_konselor_view.dart';
import '../../profileKonselor/views/profile_konselor_view.dart';
import '../controllers/navigation_konselor_controller.dart';

class NavigationKonselorView extends GetView<NavigationKonselorController> {
  const NavigationKonselorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      const HomepageKonselorView(),
      const EditJadwalView(),
      const ProfileKonselorView(),
    ];

    return Obx(() => Scaffold(
          body: _pages[controller.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changePage,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Jadwal',
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
