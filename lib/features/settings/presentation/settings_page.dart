import 'dart:developer';
import 'package:country_currency_pickers/countries.dart';
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:trading_diary/domain/model/currency_symbols.dart';
import 'package:trading_diary/features/currencies_list/bloc/currency_bloc.dart';
import 'package:trading_diary/features/settings/bloc/balance_bloc.dart';
import 'package:trading_diary/services/shared_pref_service.dart';
import 'package:trading_diary/styles/styles.dart';

part 'currency_bloc_example.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final focusNode = FocusNode();

    /// Uncomment the line below to see the CurrencyBlocExample
    // return CurrencyBlocExample();
    return BlocBuilder<BalanceBloc, BalanceState>(
      builder: (context, state) {
        final settingsBloc = BlocProvider.of<BalanceBloc>(context);
        final stateStartingBalance = settingsBloc.state.startingBalance;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.color_lens),
                  title: const Text('Dark Theme'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.scale(
                        scale: 1.2,
                        child: Switch(
                          value: themeProvider.darkTheme,
                          onChanged: (bool value) {
                            themeProvider.toggleTheme(value);
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.11,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.monetization_on,
                  ),
                  title: const Text('Starting Balance'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 40.0,
                        width: 95.0,
                        child: IgnorePointer(
                          child: TextFormField(
                            enableInteractiveSelection: false,
                            focusNode: focusNode,
                            keyboardType: TextInputType.phone,
                            initialValue:
                                stateStartingBalance.toStringAsFixed(0),
                            textAlign: TextAlign.center,
                            decoration: Styles.kTextFieldDecoration,
                            onChanged: (String value) {
                              settingsBloc.add(
                                ChangeStartingBalanceEvent(
                                  newStartingBalance: double.tryParse(
                                        value,
                                      ) ??
                                      0.0,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: InkWell(
                            onTap: () => focusNode.requestFocus(),
                            child: Icon(
                              Icons.edit_outlined,
                              color: ThemeData().colorScheme.primary,
                            )
                            //color: Theme.of(context).primaryColor),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
