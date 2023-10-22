import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        tileColor: Colors.amber,
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
    );
  }
}
