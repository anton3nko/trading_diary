import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trading_diary/features/dashboard/presentation/custom_tile.dart';

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
                top: 50,
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
              height: 40.0,
            ),
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
              height: 30,
            ),
            SizedBox(
              height: 150,
              child: ListView(
                children: const [
                  CustomTile(title: 'MACD-CCI'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
