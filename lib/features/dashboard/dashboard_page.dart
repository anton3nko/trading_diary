import 'package:flutter/material.dart';
import 'package:trading_diary/features/dashboard/widgets/app_pie_chart.dart';
import 'package:trading_diary/features/dashboard/widgets/custom_tile.dart';
import 'package:trading_diary/features/widgets/date_range_picker.dart';
import 'package:trading_diary/features/dashboard/widgets/nested_tab_bar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Padding(
                padding: EdgeInsets.only(),
                child: Text(
                  '\$2200.89',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
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
                        DateRangePicker(),
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
                  Column(
                    children: [
                      CustomTile(
                        title: 'MACD-CCI',
                        onTap: () => 'onTap',
                        tileColor: Colors.red.shade500,
                      ),
                      CustomTile(
                        title: 'Trend Channel',
                        onTap: () => 'onTap',
                        tileColor: Colors.amber.shade300,
                      ),
                      CustomTile(
                        title: 'MACD-CCI',
                        onTap: () => 'onTap',
                        tileColor: Colors.greenAccent,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomTile(
                        title: 'GPBUSD',
                        onTap: () => 'onTap',
                        tileColor: Colors.pink,
                      ),
                      CustomTile(
                        title: 'NZDUSD',
                        onTap: () => 'onTap',
                        tileColor: Colors.deepPurple,
                      ),
                      CustomTile(
                        title: 'GBPJPY',
                        onTap: () => 'onTap',
                        tileColor: Colors.yellowAccent,
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
