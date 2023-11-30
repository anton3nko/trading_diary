import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:trading_diary/domain/model/currency_pair.dart';
// import 'package:trading_diary/domain/model/strategy.dart';
// import 'package:trading_diary/domain/model/trading_transaction.dart';
// import 'package:trading_diary/features/transactions/bloc/transaction_bloc.dart';

class TransactionAddPage extends StatefulWidget {
  static const String id = 'transaction_add_page';
  const TransactionAddPage({super.key});

  @override
  State<TransactionAddPage> createState() => _TransactionAddPageState();
}

class _TransactionAddPageState extends State<TransactionAddPage> {
  //late TextEditingController _typeFieldController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const Column(),
        ),
      ),
    );
  }
}

// Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: BlocBuilder<TransactionBloc, TransactionState>(
//           builder: (context, state) {
//             return SizedBox(
//               height: MediaQuery.of(context).size.height,
//               child: Column(
//                 children: [
//                   TextButton(
//                       //onPressed: () {},
//                       onPressed: () {
//                         CurrencyPair fakeCurrency = CurrencyPair(
//                           currencyPairTitle: 'USDCHF',
//                         );
//                         DateTime openDate = DateTime(2023, 9, 7, 17, 30);
//                         DateTime closeDate = DateTime(2023, 9, 7, 18, 45);
//                         Strategy mainStrategy =
//                             Strategy(title: 'Trend Channel');
//                         context.read<TransactionBloc>().add(
//                               AddTransactionEvent(
//                                 transactionType: TransactionType.buy,
//                                 volume: 0.5,
//                                 currencyPair: fakeCurrency,
//                                 openDate: openDate,
//                                 closeDate: closeDate,
//                                 mainStrategy: mainStrategy,
//                                 secondaryStrategy: mainStrategy,
//                                 timeFrame: TimeFrame.h1,
//                                 profit: 10.5,
//                                 comment: '1st transaction',
//                               ),
//                             );
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             duration: Duration(seconds: 1),
//                             content: Text('Transaction added successfully'),
//                           ),
//                         );
//                         context
//                             .read<TransactionBloc>()
//                             .add(const FetchTransactionsEvent());
//                         Navigator.pop(context);
//                       },
//                       child: const Text('Add Fake Transaction')),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
