import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';
import 'package:trading_diary/features/settings/bloc/balance_bloc.dart';
import 'package:trading_diary/features/transactions/bloc/transaction_bloc.dart';
import 'package:trading_diary/features/transactions/presentation/transaction_add_page.dart';
import 'package:trading_diary/features/transactions/presentation/transaction_edit_page.dart';

class TransactionExpansionTile extends StatefulWidget {
  const TransactionExpansionTile({super.key, required this.transaction});

  final TradingTransaction transaction;

  @override
  State<TransactionExpansionTile> createState() =>
      _TransactionExpansionTileState();
}

//TODO Добавить кнопку редактирования
class _TransactionExpansionTileState extends State<TransactionExpansionTile> {
  bool isExpanded = false;
  final ExpansionTileController _controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
      final transactionBloc = BlocProvider.of<TransactionBloc>(context);
      return ExpansionTile(
        controller: _controller,
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
              '${DateFormat.Hm().format(widget.transaction.openDate)} ${DateFormat.yMd().format(widget.transaction.openDate)}',
              style: const TextStyle(
                fontSize: 10.0,
              ),
            )
          ],
        ),
        trailing: widget.transaction.profit == null
            ? const Text('Opened')
            : (widget.transaction.profit!.isNegative
                ? Text('-\$${widget.transaction.profit!.abs()}')
                : Text('\$${widget.transaction.profit}')),
        expandedAlignment: Alignment.topLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: const EdgeInsets.all(10.0),
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
            leading: Text('Time Frame: ${widget.transaction.timeFrame.name}'),
          ),
          ListTile(
            leading: widget.transaction.closeDate == null
                ? const Text('Closed Date: Opened')
                : Text(
                    'Closed Date: ${DateFormat.Hm().format(widget.transaction.closeDate!)} ${DateFormat.yMd().format(widget.transaction.closeDate!)}',
                  ),
          ),
          ListTile(
            leading: widget.transaction.comment == ''
                ? const Text('Comment: -')
                : Text('Comment: ${widget.transaction.comment!}'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                  ),
                  onPressed: () {
                    transactionBloc.add(
                        DeleteTransactionEvent(id: widget.transaction.id!));
                    context
                        .read<BalanceBloc>()
                        .add(const CalculateCurrentProfitEvent());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 500),
                        content: Text('Deleted Transaction'),
                      ),
                    );
                    _controller.collapse();
                  },
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (cx) {
                          return TransactionEditPage(
                            transaction: widget.transaction,
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Edit')),
              ),
            ],
          ),
        ],
      );
    });
  }
}
