import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trading_diary/features/dashboard/presentation/custom_tile.dart';
import 'package:trading_diary/features/widgets/date_range_picker.dart';

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
              height: 30,
            ),
            Flexible(
              child: SizedBox(
                height: 175,
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
            ),
          ],
        ),
      ),
    );
  }
}
