import 'package:flutter/material.dart';
import 'package:trading_diary/domain/model/currency_pair.dart';
import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';
import 'package:trading_diary/features/widgets/date_range_picker.dart';
import 'package:trading_diary/features/transactions/data/bloc/trading_transaction_bloc.dart';
import 'package:trading_diary/styles/styles.dart';
import 'package:trading_diary/features/transactions/presentation/trading_transaction_add_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    //TODO Добавление здесь FloatingActionButton ломает Add-button на Strategies page
    //Как лучше это пофиксить?
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: kYellowColor,
      //   child: const Icon(
      //     Icons.add,
      //     size: 30,
      //     color: kBlackColor,
      //   ),
      //   onPressed: () {
      //     //addFakeTransaction('USDCAD');
      //     Navigator.pushNamed(context, TradingTransactionAddPage.id);
      //   },
      // ),
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
                const DateRangePicker(),
                const SizedBox(
                  height: 20.0,
                ),
                BlocBuilder<TradingTransactionBloc, TradingTransactionState>(
                  builder: (context, state) {
                    if (state is TradingTransactionInitialState) {
                      context
                          .read<TradingTransactionBloc>()
                          .add(const FetchTradingTransactionsEvent());
                    }
                    if (state is DisplayTradingTransactionsState) {
                      return SafeArea(
                          child: Container(
                        padding: const EdgeInsets.all(8.0),
                        height: MediaQuery.of(context).size.height,
                        child: state.transactions.isNotEmpty
                            ? ListView.builder(
                                itemCount: state.transactions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    shape: kRoundedRectangleTileShape,
                                    leading: Text(state.transactions[index]
                                        .currencyPair.currencyPairTitle),
                                    trailing: Row(
                                      children: [
                                        Text(
                                            '${state.transactions[index].profit.toString()}\$'),
                                        IconButton(
                                            onPressed: () {
                                              context
                                                  .read<
                                                      TradingTransactionBloc>()
                                                  .add(
                                                    DeleteTradingTransactionEvent(
                                                        id: state
                                                            .transactions[index]
                                                            .id!),
                                                  );
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                  );
                                })
                            : const Text(''),
                      ));
                    }
                    return Container(
                      color: Colors.white,
                      child: const CircularProgressIndicator(),
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
