import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:trading_diary/features/dashboard/widgets/app_pie_chart.dart';
import 'package:trading_diary/features/dashboard/widgets/custom_tile.dart';
import 'package:trading_diary/features/widgets/date_range_picker.dart';
import 'package:trading_diary/features/dashboard/widgets/nested_tab_bar.dart';

import 'package:trading_diary/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:trading_diary/styles/settings_provider.dart';

class DashboardPage extends StatefulWidget {
  final DashboardBloc dashboardBloc;
  const DashboardPage({super.key, required this.dashboardBloc});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.dashboardBloc.state is DashboardInitialState) {
      widget.dashboardBloc.add(const FetchDashboardDataEvent());
    }
    return DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: Text(
                  'Balance',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: Consumer<SettingsProvider>(
                    builder: (context, provider, child) {
                  //FIXME При запуске приложения
                  //здесь отображается значение из SharedPreferences
                  return Text(
                    '\$${provider.startingBalance + provider.currentProfit}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 5.0,
              ),
              //For test purposes
              BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                return Consumer<SettingsProvider>(
                    builder: (context, provider, child) {
                  return IconButton(
                    onPressed: () async {
                      log(provider.startingBalance.toString());
                      provider.calculateProfit();
                      //await TransactionsRepo.instance.calculateTopStrategies();
                      context
                          .read<DashboardBloc>()
                          .add(const FetchDashboardDataEvent());
                    },
                    icon: const Icon(
                      Icons.refresh,
                    ),
                  );
                });
              }),
              const SizedBox(
                height: 32.0,
              ),
              SizedBox(
                width: 250,
                height: 250,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const AppPieChart(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Profit'),
                        BlocBuilder<DashboardBloc, DashboardState>(
                            builder: (context, state) {
                          final dashboardBloc = context.read<DashboardBloc>();
                          return DateRangePicker(
                            startDate: dashboardBloc.startDate,
                            endDate: dashboardBloc.endDate,
                            onSelect: (DateTimeRange dateTimeRange) {
                              setState(() {
                                dashboardBloc.startDate = dateTimeRange.start;
                                dashboardBloc.endDate = dateTimeRange.end;
                              });
                              dashboardBloc
                                  .add(const FetchDashboardDataEvent());
                            },
                          );
                        }),
                        const Text('Transactions'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              NestedTabBar(
                tabs: [
                  BlocBuilder<DashboardBloc, DashboardState>(
                      builder: (context, state) {
                    if (state is DisplayDashboardDataState) {
                      final topStrategiesData = state.topStrategiesData;
                      return ListView.builder(
                        itemCount: topStrategiesData.length,
                        itemBuilder: (context, index) {
                          return CustomTile(
                            title: topStrategiesData[index]['title'],
                            tileColor: Color(topStrategiesData[index]['color'])
                                .withOpacity(1),
                            profitableCount: topStrategiesData[index]
                                    ['profitable']
                                .toString(),
                            totalCount: topStrategiesData[index]['total_count']
                                .toString(),
                            totalProfit:
                                topStrategiesData[index]['profit'].toString(),
                          );
                        },
                      );
                    } else {
                      return const Text('Waiting For New Transactions...');
                    }
                  }),
                  // Column(
                  //   children: [
                  //     CustomTile(
                  //       title: 'MACD-CCI',
                  //       onTap: () => 'onTap',
                  //       tileColor: Colors.red.shade500,
                  //     ),
                  //     CustomTile(
                  //       title: 'Trend Channel',
                  //       onTap: () => 'onTap',
                  //       tileColor: Colors.amber.shade300,
                  //     ),
                  //     CustomTile(
                  //       title: 'MACD-CCI',
                  //       onTap: () => 'onTap',
                  //       tileColor: Colors.greenAccent,
                  //     ),
                  //   ],
                  // ),
                  const Column(
                    children: [
                      CustomTile(
                        title: 'GPBUSD',
                        //onTap: () => 'onTap',
                        tileColor: Colors.pink,
                        profitableCount: '10',
                        totalCount: '11',
                        totalProfit: '12.3',
                      ),
                      CustomTile(
                        title: 'NZDUSD',
                        //onTap: () => 'onTap',
                        tileColor: Colors.green,
                        profitableCount: '10',
                        totalCount: '11',
                        totalProfit: '12.3',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
