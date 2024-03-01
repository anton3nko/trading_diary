import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/features/dashboard/widgets/app_pie_chart.dart';
import 'package:trading_diary/features/dashboard/widgets/custom_tile.dart';
import 'package:trading_diary/features/settings/bloc/balance_bloc.dart';
import 'package:trading_diary/features/dashboard/widgets/dashboard_date_picker.dart';

import 'package:trading_diary/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:trading_diary/features/transactions/presentation/transaction_add_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _nestedTabController;

  @override
  void dispose() {
    _nestedTabController.removeListener(_handleTabIndex);
    _nestedTabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(
      length: 2,
      vsync: this,
    );
    // TODO: Связал listener-ом между собой индексы табов и IndexedStack
    _nestedTabController.addListener(_handleTabIndex);
  }

  void _handleTabIndex() {
    setState(() {
      _currentIndex = _nestedTabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                        '${state.currentBalance}',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ));
                }),
                const SizedBox(
                  height: 5.0,
                ),
                const DashboardDatePicker(),
                //Uncomment For test purposes
                // IconButton(
                //   onPressed: () async {
                //     context
                //         .read<DashboardBloc>()
                //         .add(const FetchDashboardDataEvent());
                //   },
                //   icon: const Icon(
                //     Icons.refresh,
                //   ),
                // ),
                const SizedBox(
                  height: 32.0,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  child: BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      return state.dashboardData.isNotEmpty()
                          ? const Stack(
                              alignment: Alignment.center,
                              children: [
                                AppPieChart(),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Profit',
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Transactions',
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // TODO: Посмотри, в чем разница между этим виджетом и GestureDetector
                                  //* Тут опционально можно сделать так, чтобы после добавления транзакции попался экран
                                  //* TransactionAddPage и обновлялся график на главной
                                  //* Делается это через Navigator.pop(context, true) и возвращение значения в предыдущий экран
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        TransactionAddPage.id,
                                      );
                                    },
                                    child: Icon(
                                      Icons.addchart_outlined,
                                      color: Theme.of(context).primaryColor,
                                      size: 90,
                                    ),
                                  ),
                                  const Text(
                                    'Add New Transaction',
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      color: Theme.of(context).splashColor.withOpacity(
                            0.3,
                          ),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _nestedTabController,
                    tabs: const [
                      Tab(
                        text: "Strategy",
                      ),
                      Tab(
                        text: "Currency Pair",
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                IndexedStack(
                  //* Вот тут видишь, мы ему провайдим высоту, а без её указания его сложно использовать, поэтому заменим эту хуйню на IndexedStack
                  index: _currentIndex,
                  children: [
                    BlocBuilder<DashboardBloc, DashboardState>(
                        builder: (context, state) {
                      if (state is DisplayDashboardDataState) {
                        final topStrategiesData =
                            state.dashboardData.topStrategiesData;
                        return ListView.builder(
                          // TODO: Здесь были два этих параметра ключевые, для того, чтобы избежать скролла ListView и взамен этого скроллить весь экран.
                          //* Но малину обосрал этот NestedTabBar с фиксированной высотой TabBarView, поэтому пришлось его выпилить к хуям
                          //* Второй опцией было сделать CustomScrollView (почитай про него, кстати) со сливерами, но это долго и муторно.
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: topStrategiesData.length,
                          itemBuilder: (context, index) {
                            return CustomTile(
                              title: topStrategiesData[index]['title'],
                              iconColor:
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
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: topCurrenciesData.length,
                            itemBuilder: (context, index) {
                              return CustomTile(
                                title: topCurrenciesData[index]
                                    ['currency_title'],
                                iconColor:
                                    Color(topCurrenciesData[index]['color'])
                                        .withOpacity(1),
                                profitableCount: topCurrenciesData[index]
                                        ['profitable']
                                    .toString(),
                                totalCount: topCurrenciesData[index]
                                        ['total_count']
                                    .toString(),
                                totalProfit: topCurrenciesData[index]['profit']
                                    .toString(),
                              );
                            },
                          );
                        } else {
                          return const Text(
                            'Waiting For New Transactions...',
                          );
                        }
                      },
                    ),
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
