import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:trading_diary/features/widgets/date_range_picker.dart';
import 'package:trading_diary/features/transactions/bloc/transaction_bloc.dart';
import 'package:trading_diary/styles/styles.dart';
import 'package:trading_diary/features/transactions/presentation/transaction_add_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:trading_diary/data/repo/transactions_repo.dart';

class TransactionsPage extends StatefulWidget {
  static const String id = 'transactions_page';
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  // void addFakeTransaction(String? currencyPairTitle) {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton(
        heroTag: 'addTransaction',
        backgroundColor: kYellowColor,
        child: const Icon(
          Icons.add,
          size: 30,
          color: kBlackColor,
        ),
        onPressed: () {
          Navigator.pushNamed(context, TransactionAddPage.id);
        },
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Text(
                    'Balance',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(),
                  child: Text(
                    '\$2200.89',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                //const DateRangePicker(),
                const SizedBox(
                  height: 20.0,
                ),
                BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    if (state is TransactionInitialState) {
                      //log('state is TransactionInitialState');
                      context
                          .read<TransactionBloc>()
                          .add(const FetchTransactionsEvent());
                    }
                    if (state is DisplayTransactionsState) {
                      return SafeArea(
                          child: Container(
                        padding: const EdgeInsets.all(8.0),
                        height: MediaQuery.of(context).size.height,
                        child: state.transactions.isNotEmpty
                            ? ListView.builder(
                                itemCount: state.transactions.length,
                                itemBuilder: (context, index) {
                                  final transactionBloc =
                                      BlocProvider.of<TransactionBloc>(context);
                                  return Container(
                                    margin: const EdgeInsets.all(3.0),
                                    child: GestureDetector(
                                      child: ListTile(
                                        shape: kRoundedRectangleTileShape,
                                        leading: Column(
                                          children: [
                                            Text(state
                                                .transactions[index]
                                                .currencyPair
                                                .currencyPairTitle),
                                            Text(state.transactions[index]
                                                .mainStrategy.title),
                                          ],
                                        ),
                                        trailing: Text(state.transactions[index]
                                                    .profit !=
                                                null
                                            ? '${state.transactions[index].profit.toString()}\$'
                                            : ''),
                                      ),
                                      onLongPress: () {
                                        log('onLongPress');
                                        transactionBloc.add(
                                            DeleteTransactionEvent(
                                                id: state
                                                    .transactions[index].id!));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            duration:
                                                Duration(milliseconds: 500),
                                            content:
                                                Text('Deleted Transaction'),
                                          ),
                                        );
                                      },
                                      onDoubleTap: () {
                                        log(state.transactions.length
                                            .toString());
                                        for (var transaction
                                            in state.transactions) {
                                          log('id = ${transaction.id.toString()} currency = ${transaction.currencyPair.currencyPairTitle}');
                                        }
                                      },
                                    ),
                                  );
                                })
                            : const Text(''),
                      ));
                    }
                    //FIXME Отображается "Loading Data From The Database
                    //При нажатии на кнопку "Back" в окне добавления транзакции
                    return const Center(
                      child: SizedBox(
                        height: 250,
                        width: 250,
                        child: Text(
                          'Loading Data From The Database...',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
