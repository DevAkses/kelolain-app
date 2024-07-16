import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/homepage_controller.dart';

class HomepageView extends GetView<HomepageController> {
   const HomepageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomepageController controller = Get.put(HomepageController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomepageView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kotak Poin dan Ikon Notifikasi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(() => Text(
                          'Points: ${controller.points.value}',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      Get.toNamed('/notification');
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Gambar Geser
              Container(
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
              SizedBox(height: 20),
              // 6 Kotak Menu
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildMenuItem(
                      icon: Icons.account_balance_wallet,
                      label: 'Finance',
                      onTap: () => Get.toNamed('/finance')),
                  _buildMenuItem(
                      icon: Icons.chat,
                      label: 'Counseling',
                      onTap: () => Get.toNamed('/tab-counseling')),
                  _buildMenuItem(
                      icon: Icons.school,
                      label: 'Education',
                      onTap: () => Get.toNamed('/education')),
                  _buildMenuItem(
                      icon: Icons.calculate,
                      label: 'Calculator',
                      onTap: () => Get.toNamed('/calculator')),
                  _buildMenuItem(
                      icon: Icons.attach_money,
                      label: 'Loans',
                      onTap: () => Get.toNamed('/loan')),
                  _buildMenuItem(
                      icon: Icons.info,
                      label: 'Information',
                      onTap: () => Get.toNamed('/information')),
                ],
              ),
              SizedBox(height: 20),
              // Grafik Penghasilan dan Pengeluaran
              Text('Grafik Penghasilan dan Pengeluaran', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              _buildIncomeExpenseChart(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({required IconData icon, required String label, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(label),
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
                          .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
                          .toList(),
                      isCurved: true,
                      color: Colors.green,
                      belowBarData: BarAreaData(show: false),
                    ),
                    LineChartBarData(
                      spots: controller.expenses
                          .asMap()
                          .entries
                          .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
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
                  child: Text('Weekly'),
                ),
                ElevatedButton(
                  onPressed: () => controller.changeFilter('monthly'),
                  child: Text('Monthly'),
                ),
                ElevatedButton(
                  onPressed: () => controller.changeFilter('yearly'),
                  child: Text('Yearly'),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
