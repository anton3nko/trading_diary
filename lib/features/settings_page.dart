import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/features/currencies_list/bloc/currency_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:trading_diary/styles/theme_provider.dart';
// import 'package:trading_diary/styles/styles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CurrencyBloc>().add(GetCurrenciesSymbolsEvent());
        },
      ),
      appBar: AppBar(
        title: const Text('Currency Bloc Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocConsumer<CurrencyBloc, CurrencyState>(
              listener: (context, state) {
                if (state is CurrencyErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is CurrencyLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CurrencySymbolsData) {
                  log(state.data.symbols.toString(), name: 'currencySymbols');
                }
                return Text('List of currencies');
              },
            ),
          ],
        ),
      ),
    );

    //TODO: Uncomment this if you need it
    // Column(
    //   children: [
    //     const Align(
    //       child: Text(
    //         'Settings',
    //         style: TextStyle(
    //           fontSize: 30,
    //         ),
    //       ),
    //     ),
    //     const SizedBox(
    //       height: 20,
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Row(
    //         children: [
    //           const Text(
    //             'Theme mode',
    //             style: TextStyle(
    //               fontSize: 20,
    //             ),
    //           ),
    //           const SizedBox(
    //             width: 35.0,
    //           ),
    //           //Добавил DropdownMenu для выбора темы приложения. Дефолтное значение = system
    //           Consumer<SettingsProvider>(builder: (context, provider, child) {
    //             return DropdownMenu<String>(
    //               initialSelection: provider.currentTheme,
    //               dropdownMenuEntries: const [
    //                 DropdownMenuEntry(
    //                   label: 'Light',
    //                   value: 'light',
    //                 ),
    //                 DropdownMenuEntry(
    //                   label: 'Dark',
    //                   value: 'dark',
    //                 ),
    //                 DropdownMenuEntry(
    //                   label: 'System',
    //                   value: 'system',
    //                 ),
    //               ],
    //               onSelected: (String? value) {
    //                 provider.changeTheme(value ?? 'system');
    //               },
    //             );
    //           }),
    //         ],
    //       ),
    //     ),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Row(
    //         children: [
    //           const Text(
    //             'Starting Balance',
    //             style: TextStyle(fontSize: 20.0),
    //           ),
    //           const SizedBox(
    //             width: 10,
    //           ),
    //           Consumer<SettingsProvider>(builder: (context, provider, child) {
    //             return SizedBox(
    //               width: 100,
    //               child: TextFormField(
    //                 initialValue: provider.balance.toString(),
    //                 textAlign: TextAlign.right,
    //                 inputFormatters: Styles.kDoubleSignedFormat,
    //                 keyboardType: const TextInputType.numberWithOptions(
    //                   decimal: true,
    //                   signed: false,
    //                 ),
    //                 onChanged: (String? value) {
    //                   double newBalance = double.tryParse(value!) ?? 1000;
    //                   log(newBalance.toString(), name: 'changingBalance');
    //                   provider.changeBalance(newBalance);
    //                 },
    //               ),
    //             );
    //           }),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
