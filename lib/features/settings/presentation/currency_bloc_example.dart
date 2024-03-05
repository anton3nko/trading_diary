part of 'settings_page.dart';

class CurrencyBlocExample extends StatelessWidget {
  const CurrencyBlocExample({super.key});

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

  Country? getCountryByCurrencyCode(String currencyCode) {
    try {
      return countryList.firstWhere(
        (country) =>
            country.currencyCode!.toLowerCase() == currencyCode.toLowerCase(),
      );
    } catch (error) {
      // log(
      //   "Country not found by currency code:  $currencyCode",
      //   name: 'CountryPickerUtils',
      // );
    }
    return null;
  }

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
                ),

          title: Text(currency.code),
          subtitle: Text(currency.name),
          children: [
            state is CurrencyRateData
                ? Text(
                    'Current rate - ${state.data.rates.first.rate.toString()}',
                    style: const TextStyle(
                      fontSize: 16,
                    ))
                : const LinearProgressIndicator()
          ],
        );
      },
    );
  }
}
