import 'package:flutter/material.dart';

const kYellowColor = Color(0xFFffed18);
const kBlackColor = Color(0xFF000000);

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Color(0xFFbdbdbd)),
  contentPadding: EdgeInsets.symmetric(horizontal: 10),
  filled: true,
  hintText: 'Hint Text',
  fillColor: Color(0xFFF6F6F6),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Color(0xFFbdbdbd), width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: kYellowColor, width: 2),
  ),
);
