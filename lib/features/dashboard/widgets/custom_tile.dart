import 'package:flutter/material.dart';
import 'package:trading_diary/styles/styles.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.tileColor,
  });
  final String title;
  final Function onTap;
  final Color tileColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.only(
          top: 7,
        ),
        child: ListTile(
          tileColor: tileColor,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),
          shape: kRoundedRectangleTileShape,
          leading: const Icon(Icons.area_chart_sharp),
          trailing: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\$124',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '9/10',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
