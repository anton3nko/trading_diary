import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Styles {
  static const kTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.only(left: 6),
    filled: true,
    hintText: 'Hint Text',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Color(0xFFbdbdbd), width: 1),
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
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
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
