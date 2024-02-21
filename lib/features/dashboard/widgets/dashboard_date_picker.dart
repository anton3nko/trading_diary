import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//TODO Создать 2 отдельных пикера для экранов Dashboard и Transactions
//Вопрос. Хочу использовать этот виджет на разных страницах:
//на Dashboard и Transactions. Выбранный диапозон дат будет свой для
//каждой страницы. Поэтому нужно его хранить в разных bloc(DashboardBloc, TransactionBloc).
//Как в этом виджете использовать разный bloc в завимисимости от ситуации??
//  Ответ: не думаю, что тут это необходимо. UI-элементы должны быть независимыми от бизнес-логики. В крайнем случае не грех использовать два разных пикера, просто создай отдельный класс.
//Текущее решение - передаю CallBack в конструктор
class DashboardDatePicker extends StatelessWidget {
  const DashboardDatePicker({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onSelect,
  });

  final DateTime endDate;
  final Function onSelect;
  final DateTime startDate;

  @override
  Widget build(BuildContext context) {
    String formattedStartDate = DateFormat.yMMMd().format(startDate);
    String formattedEndDate = DateFormat.yMMMd().format(endDate);
    String dateRange = '$formattedStartDate-$formattedEndDate';
    return TextButton(
      onPressed: () async {
        var testDates = await showDateRangePicker(
          keyboardType: TextInputType.url,
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (testDates != null) {
          // var format = DateFormat.yMMMd();
          // setState(() {
          //   startDate = format.format(testDates.start);
          //   endDate = format.format(testDates.end);
          // });
          //setState(() {
          onSelect(testDates);
          //dateRange = '${formattedStartDate}2-$formattedEndDate';
          //widget.startDate = testDates.start;
          //});
        }
      },
      child: Text(dateRange),
    );
  }
}
