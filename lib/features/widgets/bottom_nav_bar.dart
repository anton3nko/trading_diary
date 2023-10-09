import 'package:flutter/material.dart';
import 'package:trading_diary/styles.dart';

//Custom BottomNavigationBar class
class BottomNavBar extends StatelessWidget {
  final int currentPageIndex;
  final ValueSetter onTabTapped;

  BottomNavBar({required this.currentPageIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: kGreyColor,
      unselectedItemColor: kDartkGreyColor,
      selectedItemColor: kBlackColor,
      currentIndex: currentPageIndex,
      showUnselectedLabels: true,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.pie_chart,
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list,
          ),
          label: 'Transactions',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.auto_graph_sharp,
          ),
          label: 'Strategies',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: 'Settings',
        ),
      ],
    );
  }
}
