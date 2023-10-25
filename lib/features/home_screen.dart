import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/features/dashboard/presentation/dashboard_page.dart';
import 'package:trading_diary/features/settings_page.dart';
import 'package:trading_diary/features/strategies_page.dart';
import 'package:trading_diary/features/transactions_page.dart';
import 'package:trading_diary/features/widgets/app_nav_bar/app_nav_bar.dart';
import 'package:trading_diary/features/widgets/app_nav_bar/nav_bar_cubit.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: context.watch<NavBarCubit>().pageIndex,
          children: const [
            DashboardPage(),
            TransactionsPage(),
            Center(
              child: Text(
                'Add strategy',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            StrategiesPage(),
            SettingsPage(),
          ],
        ),
        bottomNavigationBar: const AppNavBar(),
      ),
    );
  }
}
