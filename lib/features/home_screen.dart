import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:trading_diary/features/dashboard/dashboard_page.dart';
import 'package:trading_diary/features/settings_page.dart';
import 'package:trading_diary/features/strategies/presentation/strategies_page.dart';
import 'package:trading_diary/features/transactions/presentation/transactions_page.dart';
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
        backgroundColor: Colors.grey.shade200,
        body: IndexedStack(
          index: context.watch<NavBarCubit>().pageIndex,
          children: [
            BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
              final dashboardBloc = context.read<DashboardBloc>();
              return DashboardPage(
                dashboardBloc: dashboardBloc,
              );
            }),
            const TransactionsPage(),
            const StrategiesPage(),
            const SettingsPage(),
          ],
        ),
        bottomNavigationBar: const AppNavBar(),
      ),
    );
  }
}
