import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/domain/model/currency_pair.dart';
import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';
import 'package:trading_diary/domain/model/transaction_dates.dart';
import 'package:trading_diary/features/transactions/bloc/transaction_bloc.dart';
import 'package:trading_diary/features/transactions/bloc/transaction_dates_cubit.dart';
import 'package:trading_diary/styles/styles.dart';
import 'package:trading_diary/features/transactions/widgets/date_time_picker.dart';
import 'package:trading_diary/features/transactions/widgets/strategy_drop_down_menu.dart';

part 'package:trading_diary/features/transactions/widgets/transaction_add_page_widgets.dart';

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
                    TrTypeDropdownMenu(
                      typeFieldController: _typeFieldController,
                    ),
                    TrCurrencyDropdownMenu(
                      currencies: currencies,
                      currencyFieldController: _currencyFieldController,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TrTimeFrameDropdownMenu(
                  timeFrameController: _timeFrameController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                NumericTextField(
                  numericFieldController: _volumeFieldController,
                  inputFormatters: kDoubleUnsignedFormat,
                  isSigned: false,
                  hintText: 'Number of lots',
                  label: 'Volume',
                  isRequired: true,
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
                StrategyDropDownMenu(
                  labelText: 'Main Strategy',
                  isRequired: true,
                  controller: _mainStrategyController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                StrategyDropDownMenu(
                  labelText: 'Secondary Strategy',
                  isRequired: false,
                  controller: _secStrategyController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                NumericTextField(
                  numericFieldController: _profitFieldController,
                  inputFormatters: kDoubleSignedFormat,
                  isSigned: true,
                  hintText: 'Profit',
                  label: 'Profit',
                  isRequired: false,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MultilineCommentTextField(
                  commentFieldController: _commentFieldController,
                ),
                //Вопрос - так можно?
                // Ответ: да, можно, вложенные BlocBuilder'ы это ок
                //надо только обращать внимание на то, когда изменяются стейты у каждого из соответствующих блоков и ребилдятся твои виджеты
                BlocBuilder<TransactionDatesCubit, TransactionDates>(
                    builder: (context, state) {
                  return BlocBuilder<TransactionBloc, TransactionState>(
                      builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          final transactionDatesCubit =
                              BlocProvider.of<TransactionDatesCubit>(context);
                          if (_volumeFieldController.text.isNotEmpty &&
                              transactionDatesCubit.dates.openDate != null) {
                            final buyOrSell = TransactionType.fromJson(
                                _typeFieldController.text.toLowerCase());
                            final currency = CurrencyPair(
                                currencyPairTitle:
                                    _currencyFieldController.text);
                            final volume =
                                double.parse(_volumeFieldController.text);
                            //TODO добавить id(из базы) стратегии
                            final mainStrat =
                                Strategy(title: _mainStrategyController.text);
                            log((_mainStrategyController.value as Strategy)
                                .id
                                .toString());
                            final secStrat =
                                Strategy(title: _secStrategyController.text);
                            final timeFrame = TimeFrame.values
                                .byName(_timeFrameController.text);
                            final profit =
                                double.tryParse(_profitFieldController.text);
                            final comment = _commentFieldController.text;
                            log('new openDate = ${transactionDatesCubit.dates.openDate.toString()}');

                            /// Вот тут как раз мне кажется уместно будет context.read использовать для лучшей читаемости
                            context.read<TransactionBloc>().add(
                                  AddTransactionEvent(
                                    transactionType: buyOrSell,
                                    volume: volume,
                                    currencyPair: currency,
                                    openDate:
                                        transactionDatesCubit.dates.openDate!,
                                    closeDate:
                                        transactionDatesCubit.dates.closeDate,
                                    mainStrategy: mainStrat,
                                    secondaryStrategy: secStrat,
                                    timeFrame: timeFrame,
                                    profit: profit,
                                    comment: comment,
                                  ),
                                );
                            transactionDatesCubit.resetDates();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text('Transaction added successfully'),
                              ),
                            );
                            context
                                .read<TransactionBloc>()
                                .add(const FetchTransactionsEvent());
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('*Please fill required fields'
                                    .toUpperCase())));
                          }
                        },
                        child: const Text('Add Transaction'));
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
