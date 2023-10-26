import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trading_diary/features/dashboard/presentation/custom_tile.dart';
import 'package:trading_diary/features/widgets/date_range_picker.dart';
import 'package:trading_diary/features/widgets/nested_tab_bar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Center(
        child: Column(
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
              height: 5.0,
            ),
            DateRangePicker(),
            SizedBox(
              width: 250,
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.blue,
                      value: 30,
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      value: 70,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            NestedTabBar(
              tabs: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: ListView(
                    children: [
                      CustomTile(
                        title: 'MACD-CCI',
                        onTap: () => 'onTap',
                        iconColor: Colors.red.shade500,
                      ),
                      CustomTile(
                        title: 'MACD-CCI',
                        onTap: () => 'onTap',
                        iconColor: Colors.amber.shade300,
                      ),
                      CustomTile(
                        title: 'MACD-CCI',
                        onTap: () => 'onTap',
                        iconColor: Colors.greenAccent,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: ListView(
                    children: [
                      CustomTile(
                        title: 'GPBUSD',
                        onTap: () => 'onTap',
                        iconColor: Colors.pink,
                      ),
                      CustomTile(
                        title: 'NZDUSD',
                        onTap: () => 'onTap',
                        iconColor: Colors.deepPurple,
                      ),
                      CustomTile(
                        title: 'GBPJPY',
                        onTap: () => 'onTap',
                        iconColor: Colors.yellowAccent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
