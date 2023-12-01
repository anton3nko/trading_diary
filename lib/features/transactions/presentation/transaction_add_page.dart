import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/domain/model/currency_pair.dart';
import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';
import 'package:trading_diary/features/strategies/bloc/strategies_bloc.dart';
import 'package:trading_diary/features/transactions/bloc/transaction_bloc.dart';
import 'package:trading_diary/styles/styles.dart';
import 'package:trading_diary/features/transactions/widgets/date_time_picker.dart';
import 'package:trading_diary/features/transactions/widgets/strategy_drop_down_menu.dart';

class TransactionAddPage extends StatefulWidget {
  static const String id = 'transaction_add_page';

  const TransactionAddPage({super.key});

  @override
  State<TransactionAddPage> createState() => _TransactionAddPageState();
}

class _TransactionAddPageState extends State<TransactionAddPage> {
  late TextEditingController _typeFieldController;
  late TextEditingController _volumeFieldController;
  late TextEditingController _currencyFieldController;
  late TextEditingController _openDateController;
  late TextEditingController _closeDateController;
  late TextEditingController _mainStrategyController;
  late TextEditingController _secStrategyController;
  late TextEditingController _timeFrameController;
  late TextEditingController _profitFieldController;
  late TextEditingController _commentFieldController;

  List<CurrencyPair> currencies = [
    CurrencyPair(currencyPairTitle: 'USDCHF'),
    CurrencyPair(currencyPairTitle: 'GBPUSD'),
    CurrencyPair(currencyPairTitle: 'USDJPY'),
  ];

  @override
  void initState() {
    _typeFieldController = TextEditingController();
    _volumeFieldController = TextEditingController();
    _currencyFieldController = TextEditingController();
    _openDateController = TextEditingController();
    _closeDateController = TextEditingController();
    _mainStrategyController = TextEditingController();
    _secStrategyController = TextEditingController();
    _timeFrameController = TextEditingController();
    _profitFieldController = TextEditingController();
    _commentFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _typeFieldController.dispose();
    _volumeFieldController.dispose();
    _currencyFieldController.dispose();
    _openDateController.dispose();
    _closeDateController.dispose();
    _mainStrategyController.dispose();
    _secStrategyController.dispose();
    _timeFrameController.dispose();
    _profitFieldController.dispose();
    _commentFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Transaction'),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownMenu<TransactionType>(
                      hintText: '*Buy/Sell',
                      label: const Text('*Buy/Sell'),
                      controller: _typeFieldController,
                      initialSelection: TransactionType.buy,
                      dropdownMenuEntries: const [
                        DropdownMenuEntry<TransactionType>(
                            value: TransactionType.buy, label: 'Buy'),
                        DropdownMenuEntry<TransactionType>(
                            value: TransactionType.sell, label: 'Sell'),
                      ],
                      onSelected: (value) {
                        log(value.toString());
                      },
                    ),
                    DropdownMenu<CurrencyPair>(
                      initialSelection: currencies.first,
                      label: const Text('*Currency'),
                      dropdownMenuEntries: currencies
                          .map<DropdownMenuEntry<CurrencyPair>>(
                              (CurrencyPair currency) =>
                                  DropdownMenuEntry<CurrencyPair>(
                                      value: currency,
                                      label: currency.currencyPairTitle))
                          .toList(),
                      onSelected: (value) {
                        log(value!.currencyPairTitle);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                //TODO Добавить фильтр на текстовые символы(только числа)
                TextField(
                  controller: _volumeFieldController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Number of lots',
                    label: const Text('*Volume'),
                    labelStyle: kTextFieldLabelStyle,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onChanged: (value) {
                    log(value);
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DateTimePickerWidget(
                      initialButtonText: 'Open Date',
                      isRequired: true,
                    ),
                    DateTimePickerWidget(
                      initialButtonText: 'Close Date',
                      isRequired: false,
                    ),
                  ],
                ),
                const StrategyDropDownMenu(
                    labelText: 'Main Strategy', isRequired: true),
                const SizedBox(
                  height: 10.0,
                ),
                const StrategyDropDownMenu(
                    labelText: 'Secondary Strategy', isRequired: false),
                const SizedBox(
                  height: 10.0,
                ),
                //TODO Добавить фильтр на текстовые символы(только числа)
                TextField(
                  controller: _profitFieldController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Profit',
                    label: const Text('*Profit'),
                    labelStyle: kTextFieldLabelStyle,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onChanged: (value) {
                    log(value);
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: _commentFieldController,
                  keyboardType: TextInputType.multiline,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Comment',
                    label: const Text('Comment'),
                    labelStyle: kTextFieldLabelStyle,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onChanged: (value) {
                    log(value);
                  },
                ),
                ElevatedButton(
                    onPressed: () {}, child: const Text('Add Transaction')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
