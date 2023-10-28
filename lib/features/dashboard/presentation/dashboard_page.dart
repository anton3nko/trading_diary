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
            const DateRangePicker(),
            SizedBox(
              width: 250,
              height: 250,
              //Не удаётся добавить виджеты с метриками по профиту,
              //объему сделок, прибыльности/убыточности сделок
              //в центр диаграммы
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 0.0,
                  sections: [
                    PieChartSectionData(
                      color: Colors.red.shade500,
                      value: 60,
                      title: '60%',
                      radius: 100,
                    ),
                    PieChartSectionData(
                      color: Colors.amber.shade300,
                      value: 30,
                      title: '30%',
                      radius: 100,
                    ),
                    PieChartSectionData(
                      color: Colors.greenAccent,
                      value: 10,
                      title: '10%',
                      radius: 100,
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
                        //Не удаётся добавить переход на экран Strategies
                        //по нажатию на название стратегии
                        title: 'MACD-CCI',
                        onTap: () => 'onTap',
                        iconColor: Colors.red.shade500,
                      ),
                      CustomTile(
                        title: 'Trend Channel',
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
