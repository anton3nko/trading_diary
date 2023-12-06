import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trading_diary/features/transactions/bloc/transaction_dates_cubit.dart';
import 'package:trading_diary/domain/model/transaction_dates.dart';

class DateTimePickerWidget extends StatefulWidget {
  final String initialButtonText;
  final bool isRequired;

  const DateTimePickerWidget(
      {super.key, required this.initialButtonText, required this.isRequired});

  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

//TODO Изменить логику работы DatePicker'а в случае нажатия cancel
class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime dateTime = DateTime.now();
  String? dateButtonText;

  //TODO Изменить формат даты на dd:mm:yyyy в тектовом вводе showDatePicker
  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }

  //TODO Вопрос - нормальное ли решение для сохранения openDate и closeDate
  //с использованием TransactionDatesCubit и model->TransactionDates??
  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);

    //TODO Как правильно обработать этот Warning?
    final time = await _selectTime(context);
    final vm = BlocProvider.of<TransactionDatesCubit>(context);
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
    widget.isRequired ? vm.setOpenDate(dateTime) : vm.setCloseDate(dateTime);
  }

  String getDateTime() {
    return DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    String isRequiredSymbol = widget.isRequired ? '*' : '';
    return BlocBuilder<TransactionDatesCubit, TransactionDates>(
        builder: (context, state) {
      return Column(
        children: [
          Text(
            '$isRequiredSymbol${widget.initialButtonText}',
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          TextButton(
            onPressed: () async {
              await _selectDateTime(context);
              setState(() {
                dateButtonText = getDateTime();
              });
            },
            child: Text(dateButtonText ?? widget.initialButtonText),
          ),
        ],
      );
    });
  }
}
