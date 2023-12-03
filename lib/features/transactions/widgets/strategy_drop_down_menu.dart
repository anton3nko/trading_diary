import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/features/strategies/bloc/strategies_bloc.dart';

class StrategyDropDownMenu extends StatelessWidget {
  final String labelText;
  final bool isRequired;
  final TextEditingController controller;

  const StrategyDropDownMenu({
    super.key,
    required this.labelText,
    required this.isRequired,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    String isRequiredSymbol = isRequired ? '*' : '';
    return BlocBuilder<StrategyBloc, StrategyState>(
      builder: (context, state) {
        var strategiesList = context.read<StrategyBloc>().strategyList;
        return DropdownMenu<Strategy>(
          controller: controller,
          label: Text(
            '$isRequiredSymbol$labelText',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          initialSelection: strategiesList.isEmpty
              ? Strategy(title: 'none')
              : strategiesList.first,
          dropdownMenuEntries: strategiesList
              .map<DropdownMenuEntry<Strategy>>((Strategy strategy) =>
                  DropdownMenuEntry(value: strategy, label: strategy.title))
              .toList(),
          onSelected: (value) => log(value!.toString()),
        );
      },
    );
  }
}
