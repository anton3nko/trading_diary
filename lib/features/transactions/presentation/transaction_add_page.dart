import 'package:flutter/material.dart';
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
                //TODO Вопрос - не сильно ли нагруженный получился виджет?
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
                    ),
                    DropdownMenu<CurrencyPair>(
                      initialSelection: currencies.first,
                      controller: _currencyFieldController,
                      label: const Text('*Currency'),
                      dropdownMenuEntries: currencies
                          .map<DropdownMenuEntry<CurrencyPair>>(
                              (CurrencyPair currency) =>
                                  DropdownMenuEntry<CurrencyPair>(
                                      value: currency,
                                      label: currency.currencyPairTitle))
                          .toList(),
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
                ),
                //TODO BlocBuilder вложенный в BlocBuilder
                //Вопрос - так можно?
                BlocBuilder<TransactionDatesCubit, TransactionDates>(
                    builder: (context, state) {
                  return BlocBuilder<TransactionBloc, TransactionState>(
                      builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          final dates =
                              BlocProvider.of<TransactionDatesCubit>(context)
                                  .dates;
                          if (_volumeFieldController.text.isNotEmpty &&
                              dates.openDate.year != 1970) {
                            final buyOrSell = TransactionType.fromJson(
                                _typeFieldController.text.toLowerCase());
                            final currency = CurrencyPair(
                                currencyPairTitle:
                                    _currencyFieldController.text);
                            final volume =
                                double.parse(_volumeFieldController.text);
                            final mainStrat =
                                Strategy(title: _mainStrategyController.text);
                            final secStrat =
                                Strategy(title: _secStrategyController.text);
                            const timeFrame = TimeFrame.h1;
                            final profit =
                                double.tryParse(_profitFieldController.text);
                            final comment = _commentFieldController.text;

                            BlocProvider.of<TransactionBloc>(context).add(
                              AddTransactionEvent(
                                transactionType: buyOrSell,
                                volume: volume,
                                currencyPair: currency,
                                openDate: dates.openDate,
                                closeDate: dates.closeDate,
                                mainStrategy: mainStrat,
                                secondaryStrategy: secStrat,
                                timeFrame: timeFrame,
                                profit: profit,
                                comment: comment,
                              ),
                            );
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
                                content: Text('*Please fill required fileds'
                                    .toUpperCase())));
                          }

                          //log('$buyOrSell $currency $volume ${dates.openDate} ${dates.closeDate} $mainStrat $secStrat $profit $comment');
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
