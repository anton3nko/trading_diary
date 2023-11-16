import 'package:flutter/material.dart';
import 'package:trading_diary/features/strategies/strategy_add_page.dart';
import 'package:trading_diary/styles.dart';

class StrategiesPage extends StatelessWidget {
  const StrategiesPage({super.key});

  static const String id = 'strategies_page';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: kYellowColor,
          child: const Icon(
            Icons.add,
            size: 30,
            color: kBlackColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, StrategyAddPage.id);
          },
        ),
        body: const Center(
          child: Text(
            'Strategies',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
