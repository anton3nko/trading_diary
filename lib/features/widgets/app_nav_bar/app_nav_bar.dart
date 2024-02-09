import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/features/settings/bloc/settings_bloc.dart';
import 'package:trading_diary/features/widgets/app_nav_bar/nav_bar_cubit.dart';
import 'package:trading_diary/features/widgets/app_nav_bar/app_nav_bar_item.dart';
import 'package:trading_diary/features/transactions/bloc/transaction_bloc.dart';
import 'package:trading_diary/features/dashboard/bloc/dashboard_bloc.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NavBarCubit>();
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              final currentSettings =
                  BlocProvider.of<SettingsBloc>(context).state.settingsModel;
              return Container(
                height: 61,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: currentSettings.primaryColor.color,
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
                    //При смене табов не актуализируются данные по
                    //Transactions и Top Strategies(на Dashboard)
                    //Для этого решил посылать ивенты(CalculateTopStrategiesEvent
                    //и FetchTransactionsEvent)
                    BlocBuilder<DashboardBloc, DashboardState>(
                        builder: (context, state) {
                      return AppNavBarItem(
                        isActive: vm.pageIndex == 0,
                        iconSrc: Icons.pie_chart,
                        label: 'Dashboard',
                        onTap: () {
                          vm.setPageIndex(0);
                          context
                              .read<DashboardBloc>()
                              .add(const FetchDashboardDataEvent());
                        },
                      );
                    }),
                    BlocBuilder<TransactionBloc, TransactionState>(
                        builder: (context, state) {
                      return AppNavBarItem(
                        isActive: vm.pageIndex == 1,
                        iconSrc: Icons.list,
                        label: 'Transactions',
                        onTap: () {
                          vm.setPageIndex(1);
                          context
                              .read<TransactionBloc>()
                              .add(const FetchTransactionsEvent());
                        },
                      );
                    }),
                    AppNavBarItem(
                      isActive: vm.pageIndex == 2,
                      iconSrc: Icons.auto_graph_sharp,
                      label: 'Strategies',
                      onTap: () {
                        vm.setPageIndex(2);
                      },
                    ),
                    AppNavBarItem(
                      isActive: vm.pageIndex == 3,
                      iconSrc: Icons.settings,
                      label: 'Settings',
                      onTap: () {
                        vm.setPageIndex(3);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: CircleAvatar(
          //     backgroundColor: Colors.orange,
          //     radius: 34,
          //     child: CircleAvatar(
          //       backgroundColor: Colors.orange,
          //       radius: 30,
          //       child: IconButton(
          //         padding: EdgeInsets.zero,
          //         onPressed: () {
          //           vm.setPageIndex(2);
          //         },
          //         icon: const Icon(
          //           Icons.add,
          //           color: Colors.white,
          //           size: 32,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
