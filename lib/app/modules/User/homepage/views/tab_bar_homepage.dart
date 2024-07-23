import 'package:flutter/material.dart';
import 'package:safeloan/app/modules/User/homepage/views/list_category_by_day.dart';
import 'package:safeloan/app/modules/User/homepage/views/list_category_by_months.dart';
import 'package:safeloan/app/modules/User/homepage/views/list_category_by_weeks.dart';

class TabBarHomepage extends StatefulWidget {
  const TabBarHomepage({
    Key? key,
  }) : super(key: key);

  @override
  _TabBarHomepageState createState() => _TabBarHomepageState();
}

class _TabBarHomepageState extends State<TabBarHomepage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Homepage'),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Harian'),
                  Tab(text: 'Mingguan'),
                  Tab(text: 'Bulanan'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ListCategoryByDays(),
                ListCategoryByWeeks(),
                ListCategoryByMonths(),
              ],
            ),
        ),
      ),
    );
  }
}
