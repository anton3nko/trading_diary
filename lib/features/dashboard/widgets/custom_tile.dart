import 'package:flutter/material.dart';
import 'package:trading_diary/styles/styles.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
    required this.title,
    required this.tileColor,
    required this.totalProfit,
    required this.profitableCount,
    required this.totalCount,
  });
  final String title;
  //final Function onTap;
  final Color tileColor;
  final String totalProfit;
  final String totalCount;
  final String profitableCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => 'onTap()',
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
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$totalProfit\$',
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$profitableCount/$totalCount',
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
