import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Styles {
  static const List<Color> kChartColors = [
    Color(0xFFc9ffb4),
    Color(0xFFffb6b7),
    Color(0xFFfffdb3),
    Color(0xFFb1ff6d),
    Color(0xFFffc490),
    Color(0xFFe0a0c3),
    Color(0xFF9191ff),
    Color(0xFF6efffc),
    Color(0xFFfeb6ff),
    Color(0xFF92ceff),
    Color(0xFF4affa0),
    Color(0xFFfffa48),
  ];
  static const kDropdownMenuTheme = InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: 48.0,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 7.0,
        vertical: 10.0,
      ));

  static const kTextFieldDecoration = InputDecoration(
    constraints: BoxConstraints(
      maxHeight: 48.0,
    ),
    contentPadding: EdgeInsets.only(left: 6),
    filled: true,
    hintText: 'Hint Text',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        width: 2,
      ),
    ),
  );

  static const kRoundedRectangleTileShape = RoundedRectangleBorder(
    side: BorderSide(color: Color.fromRGBO(97, 97, 97, 1), width: 1),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  static const kTextFieldLabelStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  static final List<TextInputFormatter> kDoubleUnsignedFormat =
      <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
  ];

  static final List<TextInputFormatter> kDoubleSignedFormat =
      <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'^\-?(\d+\.?\d*)?'))
  ];
}
