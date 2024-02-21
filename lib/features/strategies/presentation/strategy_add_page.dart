import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/styles/styles.dart';
import 'package:trading_diary/features/strategies/bloc/strategies_bloc.dart';

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
          leading: GestureDetector(
            child: const Icon(
              Icons.chevron_left_outlined,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _strategyTitleFieldController,
                decoration: Styles.kTextFieldDecoration.copyWith(
                  hintText: '*Strategy Title',
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
