import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/features/dashboard/bloc/dashboard_bloc.dart';

class AppPieChart extends StatefulWidget {
  const AppPieChart({
    super.key,
  });

  @override
  State<AppPieChart> createState() => _AppPieChartState();
}

class _AppPieChartState extends State<AppPieChart> {
  final _selectedSection = ValueNotifier<int?>(-1);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _selectedSection,
      builder: (context, child) {
        return BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            final dashboardData = state.dashboardData;
            return PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (event, response) {
                    _selectedSection.value =
                        response?.touchedSection?.touchedSectionIndex;
                  },
                ),
                centerSpaceRadius: _selectedSection.value == -1 ? 90 : 100,
                sectionsSpace: 2,
                sections: dashboardData.isNotEmpty()
                    ? state.dashboardData.topStrategiesPieData
                        .map((element) => PieChartSection(
                              color: Color(element['color']).withOpacity(1),
                              value: element['value'],
                              selected:
                                  _selectedSection.value == element['index'],
                              strategyName: element['title'],
                            ))
                        .toList()
                    : [],
                // sections: [
                //   PieChartSection(
                //     color: Colors.red.shade500,
                //     value: 60,
                //     selected: _selectedSection.value == 0,
                //     strategyName: 'MACD-CCI',
                //   ),
                //   PieChartSection(
                //       color: Colors.amber.shade300,
                //       value: 30,
                //       selected: _selectedSection.value == 1,
                //       strategyName: 'Trend Channel'),
                //   PieChartSection(
                //     color: Colors.greenAccent,
                //     value: 10,
                //     selected: _selectedSection.value == 2,
                //     strategyName: 'RSI',
                //   ),
                // ],
              ),
            );
          },
        );
      },
    );
  }
}

//Реализация PieChartSectionData через наследование
class PieChartSection extends PieChartSectionData {
  final String? strategyName;
  final bool selected;

  PieChartSection({
    required Color color,
    required double value,
    this.strategyName,
    required this.selected,
  }) : super(
          color: color,
          value: value,
          title: '${value.round().toString()}%',
          titlePositionPercentageOffset: .35,
          radius: selected ? 40 : 30,
          badgePositionPercentageOffset: 1.1,
          badgeWidget: selected
              ? Card(
                  color: Colors.blueGrey,
                  child: Text(
                    strategyName ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : null,
        );
}
