import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/domain/model/currency_pair.dart';
import 'package:trading_diary/domain/model/new_transaction.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';
import 'package:trading_diary/features/settings/bloc/balance_bloc.dart';
import 'package:trading_diary/features/transactions/bloc/new_transaction_cubit.dart';
import 'package:trading_diary/features/transactions/bloc/transaction_bloc.dart';
import 'package:trading_diary/features/transactions/presentation/transaction_add_page.dart';
import 'package:trading_diary/features/transactions/presentation/view_model.dart';
import 'package:trading_diary/features/transactions/widgets/date_time_picker.dart';
import 'package:trading_diary/features/transactions/widgets/strategy_drop_down_menu.dart';
import 'package:trading_diary/styles/styles.dart';

class TransactionEditPage extends StatefulWidget {
  const TransactionEditPage({super.key, required this.transaction});

  final TradingTransaction transaction;

  @override
  State<TransactionEditPage> createState() => _TransactionEditPageState();
}

class _TransactionEditPageState extends State<TransactionEditPage> {
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
    return BlocBuilder<NewTransactionCubit, NewTransaction>(
      builder: (context, state) {
        log('${widget.transaction.toJson()}');
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 14.0,
          ),
          actionsAlignment: MainAxisAlignment.center,
          title: const Center(
            child: Text('Edit Transaction'),
          ),
          content: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TrTypeChoiceChips(
                    selectedIndex: widget.transaction.transactionType ==
                            TransactionType.buy
                        ? 0
                        : 1),
                const SizedBox(
                  height: 10.0,
                ),
                DateTimePicker(
                  initialValue: widget.transaction.openDateToString(),
                  isRequired: true,
                  controller: vm.openDateController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                DateTimePicker(
                  initialValue: widget.transaction.closeDateToString(),
                  isRequired: false,
                  controller: vm.closeDateController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TrCurrencyDropdownMenu(
                  initialSelection: widget.transaction.currencyPair,
                  currencies: CurrencyPair.currenciesList,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TrTimeFrameDropdownMenu(
                  initialSelection: widget.transaction.timeFrame,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                NumericTextField(
                  initialValue: widget.transaction.volume.toString(),
                  numericFieldController: vm.volumeFieldController,
                  inputFormatters: Styles.kDoubleUnsignedFormat,
                  hintText: '*Number of lots',
                  isRequired: true,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                StrategyDropDownMenu(
                  initialValue: widget.transaction.mainStrategy,
                  labelText: 'Main Strategy',
                  isRequired: true,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                StrategyDropDownMenu(
                  initialValue: widget.transaction.secondaryStrategy,
                  labelText: 'Sec. Strategy',
                  isRequired: false,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                NumericTextField(
                  initialValue: '${widget.transaction.profit}',
                  numericFieldController: vm.profitFieldController,
                  inputFormatters: Styles.kDoubleSignedFormat,
                  hintText: 'Profit',
                  isRequired: false,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MultilineCommentTextField(
                  initialText: widget.transaction.comment,
                  commentFieldController: vm.commentFieldController,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                context
                    .read<NewTransactionCubit>()
                    .newTransaction
                    .resetNewTransaction();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<TransactionBloc>(context)
                    .add(UpdateTransactionEvent(
                  transaction: widget.transaction.copyWith(
                    transactionType: state.transactionType,
                    openDate: state.openDate,
                    closeDate: state.closeDate,
                    currencyPair: state.currencyPair,
                    timeFrame: state.timeFrame,
                    volume: double.parse(vm.volumeFieldController.text),
                    mainStrategy: state.mainStrategy,
                    secondaryStrategy: state.secondaryStrategy,
                    profit: double.tryParse(vm.profitFieldController.text),
                    comment: state.comment,
                  ),
                ));
                context
                    .read<NewTransactionCubit>()
                    .newTransaction
                    .resetNewTransaction();
                context
                    .read<BalanceBloc>()
                    .add(const CalculateCurrentProfitEvent());
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
