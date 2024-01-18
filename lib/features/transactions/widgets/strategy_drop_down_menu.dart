import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/new_transaction.dart';
import 'package:trading_diary/features/strategies/bloc/strategies_bloc.dart';
import 'package:trading_diary/features/transactions/bloc/new_transaction_cubit.dart';

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
        return BlocBuilder<NewTransactionCubit, NewTransaction>(
            builder: (context, state) {
          var newTransactionCubit = context.read<NewTransactionCubit>();
          return DropdownMenu<Strategy>(
            controller: controller,
            label: Text(
              '$isRequiredSymbol$labelText',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            initialSelection: strategiesList.isEmpty
                ? Strategy(id: 1, title: 'None')
                : strategiesList.first,
            dropdownMenuEntries: strategiesList
                .map<DropdownMenuEntry<Strategy>>((Strategy strategy) =>
                    DropdownMenuEntry(value: strategy, label: strategy.title))
                .toList(),
            onSelected: (Strategy? selected) {
              log(selected!.id.toString(), name: 'stratId');
              isRequired
                  ? newTransactionCubit.setMainStrategy(selected)
                  : newTransactionCubit.setSecStrategy(selected);
            },
          );
        });
      },
    );
  }
}
