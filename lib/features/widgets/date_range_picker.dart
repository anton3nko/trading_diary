import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePicker extends StatefulWidget {
  const DateRangePicker({super.key});

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  String startDate = DateFormat.yMMMd()
      .format(DateTime(DateTime.now().year, DateTime.now().month, 1));
  String endDate = DateFormat.yMMMd().format(DateTime.now());
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        var testDates = await showDateRangePicker(
          keyboardType: TextInputType.url,
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (testDates != null) {
          var format = DateFormat.yMMMd();
          setState(() {
            startDate = format.format(testDates.start);
            endDate = format.format(testDates.end);
          });
        }
      },
      child: Text('$startDate - $endDate'),
    );
  }
}
