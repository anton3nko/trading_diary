import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';
import 'package:trading_diary/features/transactions/bloc/transaction_bloc.dart';
import 'package:trading_diary/features/transactions/presentation/transaction_add_page.dart';

class TransactionExpansionTile extends StatefulWidget {
  const TransactionExpansionTile({super.key, required this.transaction});

  final TradingTransaction transaction;

  @override
  State<TransactionExpansionTile> createState() =>
      _TransactionExpansionTileState();
}

class _TransactionExpansionTileState extends State<TransactionExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
      return ExpansionTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('${widget.transaction.currencyPair.currencyPairTitle}, '),
                Text(
                  widget.transaction.transactionType.name.capitalize(),
                  style: TextStyle(
                      color: widget.transaction.transactionType ==
                              TransactionType.buy
                          ? const Color.fromARGB(255, 71, 132, 73)
                          : const Color.fromARGB(255, 183, 42, 65)),
                ),
                Text(' ${widget.transaction.volume}'),
              ],
            ),
            Text(
              DateFormat.yMEd().format(widget.transaction.openDate),
              style: const TextStyle(
                fontSize: 10.0,
              ),
            )
          ],
        ),
        trailing: widget.transaction.profit == null
            ? const Text('Not Closed Yet...')
            : Text('\$${widget.transaction.profit}'),
        expandedAlignment: Alignment.topLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading:
                Text('Main Strategy: ${widget.transaction.mainStrategy.title}'),
          ),
          ListTile(
            leading: Text(
                'Secondary Strategy: ${widget.transaction.secondaryStrategy.title}'),
          ),
          ListTile(
            leading: Text('Time Frame: ${widget.transaction.timeFrame}'),
          ),
          ListTile(
            leading: widget.transaction.closeDate == null
                ? const Text('Closed Date: Opened')
                : Text(
                    DateFormat.yMEd().format(widget.transaction.closeDate!),
                  ),
          ),
          ListTile(
            leading: widget.transaction.comment == null
                ? const Text('Comment: -')
                : Text(widget.transaction.comment!),
          ),
          // Text('Main Strategy: Trend Channel'),
          // Text('Sec. Strategy: Trend Channel'),
          // Text('Closed Date: 13:23 25/04/2023'),
          // Text('Time Frame: m5'),
          // Text('It\'s a comment'),
        ],
      );
    });
  }
}
