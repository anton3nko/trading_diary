import 'package:flutter/material.dart';
//import 'package:trading_diary/features/widgets/app_nav_bar/app_nav_bar_item.dart';

class CustomTile extends StatelessWidget {
  const CustomTile(
      {super.key,
      required this.title,
      required this.onTap,
      required this.tileColor});
  final String title;
  final Function onTap;
  final Color tileColor;

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
          //Решил закрасить не иконку, а весь ListTile для более
          //понятного сопоставления цветов диаграммы с цветами стратегий
          tileColor: tileColor,
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
