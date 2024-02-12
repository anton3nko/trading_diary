import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;

  const RoundedButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5.0,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        height: 50.0,
        onPressed: onPressed,
        child: Text(
          buttonName,
        ),
      ),
    );
  }
}
