import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/features/dashboard/widgets/app_pie_chart.dart';
import 'package:trading_diary/features/dashboard/widgets/custom_tile.dart';
import 'package:trading_diary/features/settings/bloc/balance_bloc.dart';
import 'package:trading_diary/features/dashboard/widgets/dashboard_date_picker.dart';
import 'package:trading_diary/features/dashboard/widgets/nested_tab_bar.dart';

import 'package:trading_diary/features/dashboard/bloc/dashboard_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

//FIXME Вопрос - когда листаю длинный список(например табу Currency Pair),
//то криво работает скролл. Как это исправить?
class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DefaultTabController(
        length: 2,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Balance',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                BlocBuilder<BalanceBloc, BalanceState>(
                    builder: (context, state) {
                  return Padding(
                      padding: const EdgeInsets.only(),
                      child: Text(
                        '${state.startingBalance}',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ));
                }),
                const SizedBox(
                  height: 5.0,
                ),
                //For test purposes
                IconButton(
                  onPressed: () async {
                    context
                        .read<DashboardBloc>()
                        .add(const FetchDashboardDataEvent());
                  },
                  icon: const Icon(
                    Icons.refresh,
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                const SizedBox(
                  width: 250,
                  height: 250,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AppPieChart(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Profit'),
                          DashboardDatePicker(),
                          Text('Transactions'),
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
                        final topStrategiesData =
                            state.dashboardData.topStrategiesData;
                        return ListView.builder(
                          itemCount: topStrategiesData.length,
                          itemBuilder: (context, index) {
                            return CustomTile(
                              title: topStrategiesData[index]['title'],
                              tileColor:
                                  Color(topStrategiesData[index]['color'])
                                      .withOpacity(1),
                              profitableCount: topStrategiesData[index]
                                      ['profitable']
                                  .toString(),
                              totalCount: topStrategiesData[index]
                                      ['total_count']
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
                    BlocBuilder<DashboardBloc, DashboardState>(
                        builder: (context, state) {
                      if (state is DisplayDashboardDataState) {
                        final topCurrenciesData =
                            state.dashboardData.topCurrenciesData;
                        return ListView.builder(
                          itemCount: topCurrenciesData.length,
                          itemBuilder: (context, index) {
                            return CustomTile(
                              title: topCurrenciesData[index]['currency_title'],
                              tileColor:
                                  Color(topCurrenciesData[index]['color'])
                                      .withOpacity(1),
                              profitableCount: topCurrenciesData[index]
                                      ['profitable']
                                  .toString(),
                              totalCount: topCurrenciesData[index]
                                      ['total_count']
                                  .toString(),
                              totalProfit:
                                  topCurrenciesData[index]['profit'].toString(),
                            );
                          },
                        );
                      } else {
                        return const Text('Waiting For New Transactions...');
                      }
                    }),
                    // const Column(
                    //   children: [
                    //     CustomTile(
                    //       title: 'GPBUSD',
                    //       //onTap: () => 'onTap',
                    //       tileColor: Colors.pink,
                    //       profitableCount: '10',
                    //       totalCount: '11',
                    //       totalProfit: '12.3',
                    //     ),
                    //     CustomTile(
                    //       title: 'NZDUSD',
                    //       //onTap: () => 'onTap',
                    //       tileColor: Colors.green,
                    //       profitableCount: '10',
                    //       totalCount: '11',
                    //       totalProfit: '12.3',
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
