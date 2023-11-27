import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/domain/model/currency_pair.dart';
import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';
import 'package:trading_diary/features/transactions/data/bloc/trading_transaction_bloc.dart';

class TradingTransactionAddPage extends StatefulWidget {
  static const String id = 'trading_transaction_add_page';
  const TradingTransactionAddPage({super.key});

  @override
  State<TradingTransactionAddPage> createState() =>
      _TradingTransactionAddPageState();
}

class _TradingTransactionAddPageState extends State<TradingTransactionAddPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder(
          builder: (context, state) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {},
                      // onPressed: () {
                      //   CurrencyPair fakeCurrency = CurrencyPair(
                      //     currencyPairTitle: 'USDCHF',
                      //   );
                      //   DateTime openDate = DateTime(2023, 9, 7, 17, 30);
                      //   DateTime closeDate = DateTime(2023, 9, 7, 18, 45);
                      //   Strategy mainStrategy = Strategy(title: 'Trend Channel');
                      //   context.read<TradingTransactionBloc>().add(
                      //         AddTradingTransactionEvent(
                      //           volume: 0.5,
                      //           currencyPair: fakeCurrency,
                      //           openDate: openDate,
                      //           closeDate: closeDate,
                      //           mainStrategy: mainStrategy,
                      //           secondaryStrategy: mainStrategy,
                      //           timeFrame: TimeFrame.h1,
                      //           profit: 10.5,
                      //           comment: '1st transaction',
                      //         ),
                      //       );
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       duration: Duration(seconds: 1),
                      //       content: Text('Transaction added successfully'),
                      //     ),
                      //   );
                      //   context
                      //       .read<TradingTransactionBloc>()
                      //       .add(const FetchTradingTransactionsEvent());
                      //   Navigator.pop(context);
                      // },
                      child: const Text('Add Fake Transaction')),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
