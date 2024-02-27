part of 'package:trading_diary/features/dashboard/widgets/app_pie_chart.dart';

class CurrenciesPieChart extends StatefulWidget {
  const CurrenciesPieChart({super.key});

  @override
  State<CurrenciesPieChart> createState() => _CurrenciesPieChartState();
}

class _CurrenciesPieChartState extends State<CurrenciesPieChart> {
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
                    ? state.dashboardData.topCurrenciesPieData
                        .map((element) => PieChartSection(
                              color: Color(element['color']).withOpacity(1),
                              value: element['value'],
                              selected:
                                  _selectedSection.value == element['index'],
                              strategyName: element['title'],
                            ))
                        .toList()
                    : [],
              ),
            );
          },
        );
      },
    );
  }
}
