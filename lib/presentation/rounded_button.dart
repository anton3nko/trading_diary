import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color textColor;
  final Color buttonColor;
  final String buttonName;
  final VoidCallback onPressed;

  RoundedButton(
      {required this.buttonColor,
      required this.textColor,
      required this.buttonName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5.0,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        height: 50.0,
        textColor: textColor,
        onPressed: onPressed,
        color: buttonColor,
        child: Text(
          buttonName,
        ),
      ),
    );
  }
}
