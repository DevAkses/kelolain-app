import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/detailProfile/controllers/detail_profile_controller.dart';
import 'package:safeloan/app/utils/AppColors.dart';
import '../controllers/homepage_controller.dart';
import 'package:badges/badges.dart' as badges;

class HomepageView extends GetView<HomepageController> {
  HomepageView({super.key});
  final RxInt _notifBadgeAmount = 3.obs;
  final RxBool _showCartBadge = true.obs;

  Widget _notifBadge() {
    return Obx(() => badges.Badge(
          position: badges.BadgePosition.topEnd(top: 3, end: 7),
          badgeAnimation: const badges.BadgeAnimation.slide(),
          showBadge: _showCartBadge.value,
          badgeStyle: badges.BadgeStyle(
            badgeColor: Colors.red,
            padding: EdgeInsets.all(5),
          ),
          badgeContent: Text(
            _notifBadgeAmount.value.toString(),
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          child: IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.grey[200],
              size: 25,
            ),
            onPressed: () {
              Get.toNamed('/notification');
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final HomepageController controller = Get.put(HomepageController());
    final DetailProfileController detailController =
        Get.put(DetailProfileController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: ListTile(
            leading: CircleAvatar(
              child: Image.network('https://via.placeholder.com/60'),
            ),
            title: const Text(
              "Selamat Datang",
              style: TextStyle(color: AppColors.textPutih),
            ),
            subtitle: Text(detailController.userData['fullName'] ?? "Anonim",
                style: const TextStyle(color: AppColors.textPutih)),
            trailing: _notifBadge()),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(height: 80),
                // Gambar Geser
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 200,
                    child: PageView.builder(
                      controller: controller.pageController,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Image.network(
                          'https://via.placeholder.com/400x200.png?text=Image+${index + 1}',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // 6 Kotak Menu
                const SizedBox(height: 20),
                // Grafik Penghasilan dan Pengeluaran
                const Text('Grafik Penghasilan dan Pengeluaran',
                    style: TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                _buildIncomeExpenseChart(controller),
              ],
            ),
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.textPutih,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: const Text(
                        "Poin: ",
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textHijauTua),
                      ),
                    ),
                    Obx(() => Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '${controller.points.value}',
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textHijauTua),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMenuItem(
                            icon: Icons.calculate,
                            label: 'Calculator',
                            onTap: () => Get.toNamed('/calculator')),
                        _buildMenuItem(
                            icon: Icons.attach_money,
                            label: 'Loans',
                            onTap: () => Get.toNamed('/loan')),
                        _buildMenuItem(
                            icon: Icons.school,
                            label: 'Education',
                            onTap: () => Get.toNamed('/education')),
                        _buildMenuItem(
                            icon: Icons.chat,
                            label: 'Counseling',
                            onTap: () => Get.toNamed('/tab-counseling')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      {required IconData icon,
      required String label,
      required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryColor),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: AppColors.textHijauTua),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeExpenseChart(HomepageController controller) {
    return Container(
      height: 200,
      child: Obx(() {
        return Column(
          children: [
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: controller.income
                          .asMap()
                          .entries
                          .map((e) =>
                              FlSpot(e.key.toDouble(), e.value.toDouble()))
                          .toList(),
                      isCurved: true,
                      color: Colors.green,
                      belowBarData: BarAreaData(show: false),
                    ),
                    LineChartBarData(
                      spots: controller.expenses
                          .asMap()
                          .entries
                          .map((e) =>
                              FlSpot(e.key.toDouble(), e.value.toDouble()))
                          .toList(),
                      isCurved: true,
                      color: Colors.red,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => controller.changeFilter('weekly'),
                  child: const Text('Weekly'),
                ),
                ElevatedButton(
                  onPressed: () => controller.changeFilter('monthly'),
                  child: const Text('Monthly'),
                ),
                ElevatedButton(
                  onPressed: () => controller.changeFilter('yearly'),
                  child: const Text('Yearly'),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
