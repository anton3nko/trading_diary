import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/styles.dart';

class StrategyAddPage extends StatefulWidget {
  static const String id = 'strategy_add_page';

  const StrategyAddPage({super.key});

  @override
  State<StrategyAddPage> createState() => _StrategyAddPageState();
}

class _StrategyAddPageState extends State<StrategyAddPage> {
  late TextEditingController strategyNameFieldController;
  @override
  void initState() {
    strategyNameFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    strategyNameFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: strategyNameFieldController,
                decoration: kTextFieldDecoration.copyWith(
                    label: const Text('Strategy Name')),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                var newStrat = Strategy(
                    title: strategyNameFieldController.text,
                    strategyColor: Colors.green);
                log(newStrat.toString());
              },
              child: const Text(
                'Add Strategy',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
