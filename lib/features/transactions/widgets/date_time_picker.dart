import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trading_diary/styles/styles.dart';

class DateTimePickerWidget extends StatefulWidget {
  final String initialButtonText;
  final bool isRequired;

  const DateTimePickerWidget(
      {super.key, required this.initialButtonText, required this.isRequired});

  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

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
      lastDate: DateTime(2030),
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
        log('${selected.hour}:${selected.minute}');
        selectedTime = selected;
      });
    }
    log(selectedTime.toString());
    return selectedTime;
  }

  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    //if (date == null) return;

    //TODO Как правильно обработать этот Warning?
    final time = await _selectTime(context);
    //if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  String getDateTime() {
    return DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    String isRequiredSymbol = widget.isRequired ? '*' : '';
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
              //log(getDateTime());
            });
            //log(widget.buttonText);
          },
          child: Text(dateButtonText ?? widget.initialButtonText),
        ),
      ],
    );
  }
}
