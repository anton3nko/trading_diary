import 'package:flutter/material.dart';
import 'package:trading_diary/features/settings/bloc/balance_bloc.dart';
import 'package:trading_diary/features/transactions/bloc/transaction_bloc.dart';
import 'package:trading_diary/features/transactions/widgets/date_range_picker.dart';
import 'package:trading_diary/features/transactions/widgets/transaction_expansion_tile.dart';
import 'package:trading_diary/features/transactions/presentation/transaction_add_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatefulWidget {
  static const String id = 'transactions_page';
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_transaction',
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.pushNamed(context, TransactionAddPage.id);
        },
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Balance',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                BlocBuilder<BalanceBloc, BalanceState>(
                    builder: (context, state) {
                  return Text(
                    '${state.currentBalance}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }),
                const SizedBox(
                  height: 5.0,
                ),
                const DateRangePicker(),
                const SizedBox(
                  height: 30.0,
                ),
                BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    if (state is TransactionInitialState) {
                      context.read<TransactionBloc>().add(
                            const FetchTransactionsEvent(),
                          );
                    }
                    if (state is DisplayTransactionsState) {
                      return state.transactions.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.transactions.length,
                              itemBuilder: (context, index) {
                                final transactionBloc =
                                    BlocProvider.of<TransactionBloc>(context);
                                return GestureDetector(
                                  child: TransactionExpansionTile(
                                    transaction: state.transactions[index],
                                  ),
                                  onLongPress: () {
                                    transactionBloc.add(DeleteTransactionEvent(
                                        id: state.transactions[index].id!));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(milliseconds: 500),
                                        content: Text('Deleted Transaction'),
                                      ),
                                    );
                                  },
                                );
                              })
                          : const Text(
                              'No Transactions For Selected Date Period...');
                      // TODO: Советую поискать в интернете какие-нибудь svg иконки (несколько разных) для пустых списков
                      //* а то текстовые сообщения не очень красиво смотрятся
                    }
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
