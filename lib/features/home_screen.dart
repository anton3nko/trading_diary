import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'settings_page.dart';
import 'transactions_page.dart';
import 'strategies_page.dart';
import 'package:trading_diary/features/widgets/bottom_nav_bar.dart';

//It's a home screen class.
class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  final pages = [
    DashboardPage(),
    TransactionsPage(),
    StrategiesPage(),
    SettingsPage(),
  ];

  void onTabTapped(dynamic index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[currentPageIndex],
        bottomNavigationBar: BottomNavBar(
          currentPageIndex: currentPageIndex,
          onTabTapped: onTabTapped,
        ),
      ),
    );
  }
}
