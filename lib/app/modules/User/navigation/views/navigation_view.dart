import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/analysis/views/analysis_view.dart';
import 'package:safeloan/app/modules/User/tab_quiz/views/tab_quiz_view.dart';
import 'package:safeloan/app/utils/warna.dart';
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
          bottomNavigationBar: SizedBox(
            height: 65,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: controller.selectedIndex.value,
                  onTap: (index) {
                    if (index != 2) {
                      controller.changePage(index);
                    }
                  },
                  selectedItemColor: Utils.biruTiga,
                  unselectedItemColor: Colors.grey,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: 'Beranda',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.attach_money),
                      label: 'Keuangan',
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox(height: 30),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.quiz),
                      label: 'Gamifikasi',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      label: 'Profil',
                    ),
                  ],
                ),
                Positioned(
                  top: -30,
                  left: MediaQuery.of(context).size.width / 2 - 35,
                  child: GestureDetector(
                    onTap: () {
                      controller.changePage(2);
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Utils.biruTiga,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(135, 209, 229, 1).withOpacity(0.7),
                            spreadRadius: 0,
                            blurRadius: 30,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Image(image: AssetImage('assets/images/maskot.png')),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
