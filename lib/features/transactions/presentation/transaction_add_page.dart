import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/domain/model/currency_pair.dart';
import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';
import 'package:trading_diary/domain/model/new_transaction.dart';
import 'package:trading_diary/features/transactions/bloc/transaction_bloc.dart';
import 'package:trading_diary/features/transactions/bloc/new_transaction_cubit.dart';
import 'package:trading_diary/features/transactions/presentation/view_model.dart';
import 'package:trading_diary/styles/styles.dart';
import 'package:trading_diary/features/transactions/widgets/date_time_picker.dart';
import 'package:trading_diary/features/transactions/widgets/strategy_drop_down_menu.dart';

part 'package:trading_diary/features/transactions/widgets/transaction_add_page_widgets.dart';

class TransactionAddPage extends StatefulWidget {
  const TransactionAddPage({super.key});

  static const String id = 'transaction_add_page';

  @override
  State<TransactionAddPage> createState() => _TransactionAddPageState();
}

class _TransactionAddPageState extends State<TransactionAddPage> {
  List<CurrencyPair> currencies = [
    CurrencyPair(
      currencyPairTitle: 'USDCHF',
    ),
    CurrencyPair(
      currencyPairTitle: 'GBPUSD',
    ),
    CurrencyPair(
      currencyPairTitle: 'USDJPY',
    ),
  ];

  final vm = TransactionAddViewModel();

  @override
  void dispose() {
    vm.disposeControllers();
    super.dispose();
  }

  @override
  void initState() {
    vm.initControllers();
    super.initState();
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TrTypeDropdownMenu(
                      typeFieldController: vm.typeFieldController,
                    ),
                    TrCurrencyDropdownMenu(
                      currencies: currencies,
                      currencyFieldController: vm.currencyFieldController,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TrTimeFrameDropdownMenu(
                  timeFrameController: vm.timeFrameController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                NumericTextField(
                  numericFieldController: vm.volumeFieldController,
                  inputFormatters: Styles.kDoubleUnsignedFormat,
                  isSigned: false,
                  hintText: 'Number of lots',
                  label: 'Volume',
                  isRequired: true,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  controller: vm.mainStrategyController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                StrategyDropDownMenu(
                  labelText: 'Sec. Strategy',
                  isRequired: false,
                  controller: vm.secStrategyController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                NumericTextField(
                  numericFieldController: vm.profitFieldController,
                  inputFormatters: Styles.kDoubleSignedFormat,
                  isSigned: true,
                  hintText: 'Profit',
                  label: 'Profit',
                  isRequired: false,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MultilineCommentTextField(
                  commentFieldController: vm.commentFieldController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                //Вопрос - так можно?
                // Ответ: да, можно, вложенные BlocBuilder'ы это ок
                //надо только обращать внимание на то, когда изменяются стейты у каждого из соответствующих блоков и ребилдятся твои виджеты
                BlocBuilder<NewTransactionCubit, NewTransaction>(
                    builder: (context, state) {
                  return BlocBuilder<TransactionBloc, TransactionState>(
                      builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          final newTransactionCubit =
                              BlocProvider.of<NewTransactionCubit>(context);
                          if (vm.volumeFieldController.text.isNotEmpty &&
                              newTransactionCubit.newTransaction.openDate !=
                                  null) {
                            final buyOrSell = TransactionType.fromJson(
                                vm.typeFieldController.text.toLowerCase());
                            final currency = CurrencyPair(
                                currencyPairTitle:
                                    vm.currencyFieldController.text);
                            final volume =
                                double.parse(vm.volumeFieldController.text);
                            final mainStrat = newTransactionCubit
                                    .newTransaction.mainStrategy ??
                                Strategy(id: 1, title: 'None');
                            final secStrat = newTransactionCubit
                                    .newTransaction.secondaryStrategy ??
                                Strategy(id: 1, title: 'None');
                            final timeFrame = TimeFrame.values
                                .byName(vm.timeFrameController.text);
                            final profit =
                                double.tryParse(vm.profitFieldController.text);
                            final comment = vm.commentFieldController.text;

                            /// Вот тут как раз мне кажется уместно будет context.read использовать для лучшей читаемости
                            context.read<TransactionBloc>().add(
                                  AddTransactionEvent(
                                    transactionType: buyOrSell,
                                    volume: volume,
                                    currencyPair: currency,
                                    openDate: newTransactionCubit
                                        .newTransaction.openDate!,
                                    closeDate: newTransactionCubit
                                        .newTransaction.closeDate,
                                    mainStrategy: mainStrat,
                                    secondaryStrategy: secStrat,
                                    timeFrame: timeFrame,
                                    profit: profit,
                                    comment: comment,
                                  ),
                                );
                            newTransactionCubit.resetNewTransaction();
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
