import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/features/dashboard/bloc/dashboard_bloc.dart';

//Вопрос. Хочу использовать этот виджет на разных страницах:
//на Dashboard и Transactions. Выбранный диапозон дат будет свой для
//каждой страницы. Поэтому нужно его хранить в разных bloc(DashboardBloc, TransactionBloc).
//Как в этом виджете использовать разный bloc в завимисимости от ситуации??
//  Ответ: не думаю, что тут это необходимо. UI-элементы должны быть независимыми от бизнес-логики. В крайнем случае не грех использовать два разных пикера, просто создай отдельный класс.
//Текущее решение - передаю CallBack в конструктор
class DashboardDatePicker extends StatelessWidget {
  const DashboardDatePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // String formattedStartDate = DateFormat.yMMMd().format(startDate);
    // String formattedEndDate = DateFormat.yMMMd().format(endDate);
    // String dateRange = '$formattedStartDate-$formattedEndDate';
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final dashboardBloc = BlocProvider.of<DashboardBloc>(context);
        return TextButton(
          onPressed: () async {
            var testDates = await showDateRangePicker(
              keyboardType: TextInputType.url,
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (testDates != null) {
              dashboardBloc.add(SetDashboardDateEvent(newDateRange: testDates));
            }
          },
          child: Text(state.dashboardData.dateRangeToString()),
        );
      },
    );
  }
}
