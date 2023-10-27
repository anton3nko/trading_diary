import 'package:flutter/material.dart';
//import 'package:trading_diary/features/widgets/app_nav_bar/app_nav_bar_item.dart';

class CustomTile extends StatelessWidget {
  const CustomTile(
      {super.key,
      required this.title,
      required this.onTap,
      required this.iconColor});
  final String title;
  final Function onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black),
            //top: BorderSide(color: Colors.black),
          ),
        ),
        child: ListTile(
          tileColor: iconColor,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),
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
