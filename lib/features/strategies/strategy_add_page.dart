import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/styles.dart';
import 'package:trading_diary/features/strategies/data/bloc/strategies_crud_bloc.dart';

class StrategyAddPage extends StatefulWidget {
  static const String id = 'strategy_add_page';

  const StrategyAddPage({super.key});

  @override
  State<StrategyAddPage> createState() => _StrategyAddPageState();
}

class _StrategyAddPageState extends State<StrategyAddPage> {
  late TextEditingController _strategyTitleFieldController;
  @override
  void initState() {
    _strategyTitleFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _strategyTitleFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add A Strategy'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _strategyTitleFieldController,
                decoration: kTextFieldDecoration.copyWith(
                    label: const Text('Strategy Name')),
              ),
            ),
            BlocBuilder<StrategyBloc, StrategyState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (_strategyTitleFieldController.text.isNotEmpty) {
                      context.read<StrategyBloc>().add(
                            AddStrategyEvent(
                              title: _strategyTitleFieldController.text,
                              color: Color.fromARGB(
                                255,
                                Random().nextInt(255),
                                Random().nextInt(255),
                                Random().nextInt(255),
                              ),
                            ),
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Strategy added successfully'),
                        ),
                      );
                      context
                          .read<StrategyBloc>()
                          .add(const FetchStrategiesEvent());
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Title field must not be blank'.toUpperCase()),
                      ));
                    }
                  },
                  child: const Text(
                    'Add Strategy',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
