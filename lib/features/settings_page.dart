import 'package:country_currency_pickers/countries.dart';
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/domain/model/currency_symbols.dart';
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
        isExtended: true,
        onPressed: () {
          context.read<CurrencyBloc>().add(GetCurrenciesSymbolsEvent());
        },
        child: const Icon(
          Icons.currency_exchange_sharp,
        ),
      ),
      appBar: AppBar(
        title: const Text('Currency Bloc Demo'),
        centerTitle: true,
      ),
      body: BlocConsumer<CurrencyBloc, CurrencyState>(
        buildWhen: (previous, current) {
          /// С помощью этого параметра ты можешь ограничить перерисовку виджета. Он будет ребилдится только при заданных условиях
          if (current is CurrencySymbolsData ||
              current is CurrencySymbolsLoading ||
              current is CurrencyErrorState) {
            return true;
          }
          return false;
        },
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
          if (state is CurrencySymbolsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CurrencySymbolsData &&
              state.data.symbols != null) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    const Text('Base Currency - EURO'),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 7,
                        );
                      },
                      itemBuilder: (context, index) {
                        final currency = state.data.symbols![index];
                        return CurrencyRateTile(
                          currency: currency,
                          onTap: () {
                            context.read<CurrencyBloc>().add(
                                  GetGurrencyRatesEvent(
                                    currency.code,
                                  ),
                                );
                          },
                        );
                      },
                      itemCount: state.data.symbols!.length,
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Text('Tap the FAB to load currency symbols'),
          );
        },
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

// Виджет для отображения валютной пары
class CurrencyRateTile extends StatelessWidget {
  const CurrencyRateTile({
    super.key,
    required this.currency,
    required this.onTap,
  });

  final Currency currency;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final country = getCountryByCurrencyCode(currency.code);
    // final ExpansionTileController controller = ExpansionTileController();
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, state) {
        return ExpansionTile(
          // controller: controller,
          onExpansionChanged: (value) {
            if (value) {
              onTap?.call();
            }
          },
          leading: country != null
              ? Image.asset(
                  CountryPickerUtils.getFlagImageAssetPath(country.isoCode!),
                  height: 20.0,
                  width: 30.0,
                  fit: BoxFit.fill,
                  package: "country_currency_pickers",
                )
              : const Icon(
                  Icons.currency_exchange,
                  size: 30,
                  color: Colors.white,
                ),
          collapsedBackgroundColor: Colors.blueGrey,
          backgroundColor: Colors.blueGrey.withOpacity(0.4),
          title: Text(currency.code),
          subtitle: Text(currency.name),
          children: [
            state is CurrencyRateData
                ? Text(
                    'Current rate - ${state.data.rates.first.rate.toString()}',
                    style: const TextStyle(
                      fontSize: 16,
                    ))
                : const LinearProgressIndicator(
                    color: Colors.blueGrey,
                  )
          ],
        );
      },
    );
  }

  Country? getCountryByCurrencyCode(String currencyCode) {
    try {
      return countryList.firstWhere(
        (country) =>
            country.currencyCode!.toLowerCase() == currencyCode.toLowerCase(),
      );
    } catch (error) {
      log(
        "Country not found by currency code:  $currencyCode",
        name: 'CountryPickerUtils',
      );
    }
    return null;
  }
}
