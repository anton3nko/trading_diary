import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trading_diary/features/transactions/bloc/new_transaction_cubit.dart';
import 'package:trading_diary/styles/styles.dart';

class DateTimePickerWidget extends StatefulWidget {
  final String initialButtonText;
  final bool isRequired;
  final TextEditingController controller;

  const DateTimePickerWidget(
      {super.key,
      required this.initialButtonText,
      required this.isRequired,
      required this.controller});

  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime? dateTime;
  String? dateButtonText;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String isRequiredSymbol = widget.isRequired ? '*' : '';
    final vm = BlocProvider.of<NewTransactionCubit>(context);
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            //TODO ВОПРОС. Хочу залить эту кнопку тем же цветом,
            //что и кнопка "Add transaction" внизу формы.
            //Как выдернуть этот цвет из темы?
            onPressed: () async {
              await _selectDateTime(vm);
              if (dateTime != null) {
                setState(() {
                  widget.controller.text = getDateTime();
                });
              }
            },
            child: const Icon(
              Icons.calendar_month_outlined,
            ),
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Expanded(
          flex: 5,
          child: TextField(
            controller: widget.controller,
            enabled: false,
            decoration: Styles.kTextFieldDecoration.copyWith(
              hintText: '$isRequiredSymbol${widget.initialButtonText}',
            ),
          ),
        ),
      ],
    );
    // String isRequiredSymbol = widget.isRequired ? '*' : '';
    // final vm = BlocProvider.of<NewTransactionCubit>(context);
    // return BlocBuilder<NewTransactionCubit, NewTransaction>(
    //     builder: (context, state) {
    //   return Column(
    //     children: [
    //       Text(
    //         '$isRequiredSymbol${widget.initialButtonText}',
    //         style: const TextStyle(
    //           fontSize: 13.0,
    //           fontWeight: FontWeight.bold,
    //         ),
    //         textAlign: TextAlign.left,
    //       ),
    //       TextButton(
    //         onPressed: () async {
    //           await _selectDateTime(vm);
    //           if (dateTime != null) {
    //             setState(() {
    //               dateButtonText = getDateTime();
    //             });
    //           }
    //         },
    //         child: Text(dateButtonText ?? widget.initialButtonText),
    //       ),
    //     ],
    //   );
    // });
  }

  Future<DateTime?> _selectDate() async {
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
    return selected;
  }

  Future<TimeOfDay?> _selectTime() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selected;
  }

  //Ответ: Нормальное, если тебя смущает, то можно ChangeNotifier использовать
  Future _selectDateTime(NewTransactionCubit vm) async {
    final date = await _selectDate();
    if (date != null) {
      final time = await _selectTime();
      if (time != null) {
        setState(() {
          dateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
        widget.isRequired
            ? vm.setOpenDate(dateTime!)
            : vm.setCloseDate(dateTime);
      }
    }
  }

  String getDateTime() {
    //log(dateTime!.toString());
    return DateFormat('dd-MM-yyyy HH:mm').format(dateTime!);
  }
}
