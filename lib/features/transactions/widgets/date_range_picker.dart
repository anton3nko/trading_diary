import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/features/transactions/bloc/transaction_bloc.dart';

//Отдельный DateRangePicker для TransactionsPage
//по аналогии с Dashboard->DashboardDatePicker()
class DateRangePicker extends StatelessWidget {
  const DateRangePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        final transactionsBloc = BlocProvider.of<TransactionBloc>(context);
        return TextButton(
          onPressed: () async {
            var testDates = await showDateRangePicker(
              keyboardType: TextInputType.url,
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (testDates != null) {
              transactionsBloc
                  .add(SetTransactionsDateEvent(newDateRange: testDates));
            }
          },
          child: Text(
            transactionsBloc.dateRangeToString(),
          ),
        );
      },
    );
  }
}
