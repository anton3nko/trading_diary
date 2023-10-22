import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:trading_diary/features/dashboard_page.dart';
// import 'package:trading_diary/features/settings_page.dart';
// import 'package:trading_diary/features/strategies_page.dart';
// import 'package:trading_diary/features/transactions_page.dart';
import 'package:trading_diary/features/widgets/app_nav_bar/nav_bar_cubit.dart';
import 'package:trading_diary/features/widgets/app_nav_bar/app_nav_bar_item.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NavBarCubit>();
    return SizedBox(
      height: 91,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 61,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 12,
                  offset: const Offset(
                    0,
                    -16,
                  ),
                ),
              ],
            ),
            child: Row(
              children: [
                AppNavBarItem(
                  isActive: vm.pageIndex == 0,
                  iconSrc: Icons.pie_chart,
                  label: 'Dashboard',
                  onTap: () {
                    vm.setPageIndex(0);
                  },
                ),
                AppNavBarItem(
                  isActive: vm.pageIndex == 1,
                  iconSrc: Icons.list,
                  label: 'Transactions',
                  onTap: () {
                    vm.setPageIndex(1);
                  },
                ),
                const Spacer(),
                AppNavBarItem(
                  isActive: vm.pageIndex == 3,
                  iconSrc: Icons.auto_graph_sharp,
                  label: 'Strategies',
                  onTap: () {
                    vm.setPageIndex(3);
                  },
                ),
                AppNavBarItem(
                  isActive: vm.pageIndex == 4,
                  iconSrc: Icons.settings,
                  label: 'Settings',
                  onTap: () {
                    vm.setPageIndex(4);
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 34,
              child: CircleAvatar(
                backgroundColor: Colors.orange,
                radius: 30,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    vm.setPageIndex(2);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
