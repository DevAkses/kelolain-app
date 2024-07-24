// import 'package:fl_chart/fl_chart.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/modules/User/homepage/views/list_category_by_day.dart';
import 'package:safeloan/app/modules/User/homepage/views/list_category_by_months.dart';
import 'package:safeloan/app/modules/User/homepage/views/list_category_by_weeks.dart';
import 'package:safeloan/app/modules/User/profile/controllers/profile_controller.dart';
import 'package:safeloan/app/utils/warna.dart';
import '../controllers/homepage_controller.dart';
import 'package:badges/badges.dart' as badges;

class HomepageView extends GetView<HomepageController> {
  HomepageView({super.key});
  final RxInt _notifBadgeAmount = 3.obs;
  final RxBool _showCartBadge = true.obs;

  Widget _notifBadge() {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 3, end: 7),
      badgeAnimation: const badges.BadgeAnimation.slide(),
      showBadge: _showCartBadge.value,
      badgeStyle: const badges.BadgeStyle(
        badgeColor: Colors.red,
        padding: EdgeInsets.all(5),
      ),
      badgeContent: Text(
        _notifBadgeAmount.value.toString(),
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.grey[800],
            size: 25,
          ),
          onPressed: () {
            Get.toNamed('/notification');
          },
        ),
      ),
    );
  }

  Widget poin(String icon, String poin) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Utils.backgroundCard,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const []),
          child: Row(
            children: [
              Image.asset(icon),
              const SizedBox(
                width: 5,
              ),
              Text(
                poin,
                style: const TextStyle(fontSize: 12),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final HomepageController controller = Get.put(HomepageController());
    final ProfileController detailController =
        Get.put(ProfileController());
    var lebar = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    ListTile(
                      title: const Text(
                        "Hai! Selamat Datang",
                        style: Utils.header,
                      ),
                      subtitle: Obx(
                        () => Text(
                            detailController.userData['fullName'] ?? "Anonim",
                            style: const TextStyle(color: Colors.black)),
                      ),
                      trailing: _notifBadge(),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: lebar * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(
                            () => poin("assets/images/poin.png",
                                '${controller.points.value}'),
                          ),
                          poin("assets/images/koin.png", 'belum ada'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Utils.backgroundCard,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildMenuItem(
                              icon: Icons.school,
                              label: 'Edukasi',
                              onTap: () => Get.toNamed('/education')),
                          _buildMenuItem(
                              icon: Icons.chat,
                              label: 'Konseling',
                              onTap: () => Get.toNamed('/tab-counseling')),
                          _buildMenuItem(
                              icon: Icons.calculate,
                              label: 'Kalkulasi',
                              onTap: () => Get.toNamed('/calculator')),
                          _buildMenuItem(
                              icon: Icons.attach_money,
                              label: 'Pinjaman',
                              onTap: () => Get.toNamed('/loan')),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(
                  () => CarouselSlider.builder(
                    itemCount: controller.articleImages.length,
                    itemBuilder: (context, index, realIndex) {
                      var article = controller.articleImages[index];
                      return Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            height: 200,
                            decoration: BoxDecoration(
                              color: Utils.backgroundCard,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () =>
                                  controller.navigateToDetailArticle(article),
                              child: Center(
                                child: Image.network(
                                  article.image,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            bottom: 15,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black38,
                              ),
                              child: Text(
                                article.title.length > 20
                                    ? "Artikel : ${article.title.substring(0, 20)}..."
                                    : "Artikel : ${article.title}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    options: CarouselOptions(
                      height: 205,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(2),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Utils.backgroundCard,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 0,
                            blurRadius: 30,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: TabBar(
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Utils.biruTiga,
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Utils.biruTiga,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          tabs: const [
                            Tab(text: 'Harian'),
                            Tab(text: 'Mingguan'),
                            Tab(text: 'Bulanan'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 400,
                      child: Expanded(
                          child: TabBarView(
                        children: [
                          ListCategoryByDays(),
                          ListCategoryByWeeks(),
                          ListCategoryByMonths(),
                        ],
                      )),
                    )
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
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
          Icon(icon, color: Utils.biruDua),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Utils.biruDua),
          ),
        ],
      ),
    );
  }
}



//                 // Grafik Penghasilan dan Pengeluaran
//                 // Padding(
//                 //   padding: const EdgeInsets.all(16.0),
//                 //   child: Column(
//                 //     crossAxisAlignment: CrossAxisAlignment.start,
//                 //     children: [
//                 //       const Text('Grafik Penghasilan dan Pengeluaran',
//                 //           style: TextStyle(
//                 //               fontSize: 16,
//                 //               fontWeight: FontWeight.bold,
//                 //               color: Utils.biruDua)),
//                 //       const SizedBox(height: 10),
//                 //       // Dropdown Filter
//                 //       Obx(() => DropdownButton<String>(
//                 //             value: _selectedPeriod.value,
//                 //             icon: const Icon(Icons.arrow_drop_down,
//                 //                 color: Colors.blue),
//                 //             iconSize: 24,
//                 //             elevation: 16,
//                 //             style: const TextStyle(
//                 //                 color: Utils.biruDua,
//                 //                 fontSize: 16,
//                 //                 fontWeight: FontWeight.bold),
//                 //             dropdownColor: Colors.white,
//                 //             underline: Container(
//                 //               height: 2,
//                 //               color: Utils.biruDua,
//                 //             ),
//                 //             items: <String>['Weekly', 'Monthly', 'Yearly']
//                 //                 .map((String value) {
//                 //               return DropdownMenuItem<String>(
//                 //                 value: value,
//                 //                 child: Padding(
//                 //                   padding: const EdgeInsets.symmetric(
//                 //                       horizontal: 8.0),
//                 //                   child: Text(value),
//                 //                 ),
//                 //               );
//                 //             }).toList(),
//                 //             onChanged: (String? newValue) {
//                 //               if (newValue != null) {
//                 //                 _selectedPeriod.value = newValue;
//                 //                 controller.changeFilter(newValue.toLowerCase());
//                 //               }
//                 //             },
//                 //             hint: const Text(
//                 //               "Select Period",
//                 //               style:
//                 //                   TextStyle(color: Colors.grey, fontSize: 16),
//                 //             ),
//                 //           )),
//                 //       const SizedBox(height: 10),
//                 //       _buildIncomeExpenseChart(controller),
//                 //     ],
//                 //   ),
//                 // ),
//               ],
//             ),
//           )),
//     );
//   }



//   // Widget _buildIncomeExpenseChart(HomepageController controller) {
//   //   return Container(
//   //     height: 250,
//   //     padding: const EdgeInsets.all(8.0),
//   //     decoration: BoxDecoration(
//   //       color: Utils.backgroundCard,
//   //       borderRadius: BorderRadius.circular(12),
//   //       boxShadow: [
//   //         BoxShadow(
//   //           color: Colors.grey.withOpacity(0.2),
//   //           spreadRadius: 1,
//   //           blurRadius: 4,
//   //           offset: const Offset(0, 2),
//   //         ),
//   //       ],
//   //     ),
//   //     child: Obx(() {
//   //       return LineChart(
//   //         LineChartData(
//   //           gridData: FlGridData(
//   //             show: true,
//   //             drawVerticalLine: true,
//   //             horizontalInterval: 1,
//   //             verticalInterval: 1,
//   //             getDrawingHorizontalLine: (value) {
//   //               return const FlLine(
//   //                 color: Color(0xffe7e8ec),
//   //                 strokeWidth: 1,
//   //               );
//   //             },
//   //             getDrawingVerticalLine: (value) {
//   //               return const FlLine(
//   //                 color: Color(0xffe7e8ec),
//   //                 strokeWidth: 1,
//   //               );
//   //             },
//   //           ),
//   //           titlesData: FlTitlesData(
//   //             show: true,
//   //             bottomTitles: AxisTitles(
//   //               sideTitles: SideTitles(
//   //                 showTitles: true,
//   //                 reservedSize: 22,
//   //                 getTitlesWidget: (value, meta) {
//   //                   return Text(
//   //                     (value.toInt() % 2 == 0) ? '${value.toInt()}' : '',
//   //                     style: const TextStyle(
//   //                       color: Color(0xff68737d),
//   //                       fontWeight: FontWeight.bold,
//   //                       fontSize: 12,
//   //                     ),
//   //                   );
//   //                 },
//   //                 interval: 1,
//   //               ),
//   //             ),
//   //             leftTitles: AxisTitles(
//   //               sideTitles: SideTitles(
//   //                 showTitles: true,
//   //                 reservedSize: 28,
//   //                 getTitlesWidget: (value, meta) {
//   //                   return Text(
//   //                     (value % 500 == 0) ? '${value.toInt()}' : '',
//   //                     style: const TextStyle(
//   //                       color: Color(0xff67727d),
//   //                       fontWeight: FontWeight.bold,
//   //                       fontSize: 12,
//   //                     ),
//   //                   );
//   //                 },
//   //                 interval: 500,
//   //               ),
//   //             ),
//   //             topTitles: const AxisTitles(
//   //               sideTitles: SideTitles(showTitles: false),
//   //             ),
//   //             rightTitles: const AxisTitles(
//   //               sideTitles: SideTitles(showTitles: false),
//   //             ),
//   //           ),
//   //           borderData: FlBorderData(
//   //             show: true,
//   //             border: Border.all(
//   //               color: const Color(0xffe7e8ec),
//   //               width: 1,
//   //             ),
//   //           ),
//   //           minX: 0,
//   //           maxX: controller.income.length.toDouble() - 1,
//   //           minY: 0,
//   //           maxY: (controller.income + controller.expenses)
//   //               .reduce((a, b) => a > b ? a : b)
//   //               .toDouble(),
//   //           lineBarsData: [
//   //             LineChartBarData(
//   //               spots: controller.income
//   //                   .asMap()
//   //                   .entries
//   //                   .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
//   //                   .toList(),
//   //               isCurved: true,
//   //               color: Colors.green,
//   //               belowBarData: BarAreaData(
//   //                 show: true,
//   //                 color: Colors.green.withOpacity(0.2),
//   //               ),
//   //               dotData: const FlDotData(show: false),
//   //             ),
//   //             LineChartBarData(
//   //               spots: controller.expenses
//   //                   .asMap()
//   //                   .entries
//   //                   .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
//   //                   .toList(),
//   //               isCurved: true,
//   //               color: Colors.red,
//   //               belowBarData: BarAreaData(
//   //                 show: true,
//   //                 color: Colors.red.withOpacity(0.2),
//   //               ),
//   //               dotData: const FlDotData(show: false),
//   //             ),
//   //           ],
//   //         ),
//   //       );
//   //     }),
//   //   );
//   // }
// }
