part of 'package:trading_diary/features/transactions/presentation/transaction_add_page.dart';

extension StringExtension on String {
  // Преобразует строку 'word'.capitalize => 'Word';
  String capitalize() =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
}

//Customizable Numeric TextField for Transaction Add Page
class NumericTextField extends StatelessWidget {
  const NumericTextField({
    super.key,
    required TextEditingController numericFieldController,
    required List<TextInputFormatter> inputFormatters,
    required bool isSigned,
    required String hintText,
    required bool isRequired,
  })  : _numericFieldController = numericFieldController,
        _inputFormatters = inputFormatters,
        _hintText = hintText;

  final String _hintText;
  final List<TextInputFormatter> _inputFormatters;
  final TextEditingController _numericFieldController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: _inputFormatters,
      controller: _numericFieldController,
      keyboardType: TextInputType.phone,
      // TextInputType.numberWithOptions(
      //   decimal: true,
      //   signed: _isSigned,
      // ),
      decoration: Styles.kTextFieldDecoration.copyWith(
        hintText: _hintText,
        labelStyle: Styles.kTextFieldLabelStyle,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: (value) {
        //log(value);
      },
    );
  }
}

//Transaction Type Choice Chips
class TrTypeChoiceChips extends StatefulWidget {
  const TrTypeChoiceChips({super.key});

  @override
  State<TrTypeChoiceChips> createState() => _TrTypeChoiceChipsState();
}

class _TrTypeChoiceChipsState extends State<TrTypeChoiceChips> {
  int? _selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: List<Widget>.generate(
        TransactionType.values.length,
        (index) {
          return Padding(
            padding: const EdgeInsets.only(
              right: 5.0,
            ),
            child: ChoiceChip(
              label: Text(
                TransactionType.values[index].name.capitalize(),
                style: Styles.kTextFieldLabelStyle,
              ),
              selectedColor: Theme.of(context).colorScheme.primary,
              selected: _selectedIndex == index,
              onSelected: (value) {
                setState(() {
                  _selectedIndex = value ? index : null;
                });
                if (_selectedIndex != null) {
                  context.read<NewTransactionCubit>().setTransactionType(
                      TransactionType.values[_selectedIndex!]);
                }
              },
            ),
          );
        },
      ).toList(),
    );
  }
}

//Transaction Types List Dropdown Menu
// class TrTypeDropdownMenu extends StatelessWidget {
//   const TrTypeDropdownMenu({
//     super.key,
//     required TextEditingController typeFieldController,
//   }) : _typeFieldController = typeFieldController;

//   final TextEditingController _typeFieldController;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownMenu<TransactionType>(
//       hintText: '*Buy/Sell',
//       label: const Text('*Buy/Sell'),
//       controller: _typeFieldController,
//       initialSelection: TransactionType.buy,
//       dropdownMenuEntries: const [
//         DropdownMenuEntry<TransactionType>(
//             value: TransactionType.buy, label: 'Buy'),
//         DropdownMenuEntry<TransactionType>(
//             value: TransactionType.sell, label: 'Sell'),
//       ],
//     );
//   }
// }

//Transaction Currencies List Dropdown Menu
class TrCurrencyDropdownMenu extends StatelessWidget {
  const TrCurrencyDropdownMenu({
    super.key,
    required this.currencies,
  });

  final List<CurrencyPair> currencies;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<CurrencyPair>(
      expandedInsets: EdgeInsets.zero,
      hintText: '*Currency Pair',
      textStyle: Styles.kTextFieldLabelStyle,
      inputDecorationTheme: Styles.kDropdownMenuTheme,
      dropdownMenuEntries: currencies
          .map<DropdownMenuEntry<CurrencyPair>>(
              (CurrencyPair currency) => DropdownMenuEntry<CurrencyPair>(
                    value: currency,
                    label: currency.currencyPairTitle,
                  ))
          .toList(),
      onSelected: (CurrencyPair? selectedPair) {
        context.read<NewTransactionCubit>().setCurrencyPair(selectedPair!);
      },
    );
  }
}

//Transaction TimeFrame Dropdown Menu
class TrTimeFrameDropdownMenu extends StatelessWidget {
  const TrTimeFrameDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<TimeFrame>(
      expandedInsets: EdgeInsets.zero,
      hintText: '*TimeFrame',
      textStyle: Styles.kTextFieldLabelStyle,
      inputDecorationTheme: Styles.kDropdownMenuTheme,
      dropdownMenuEntries: TimeFrame.values
          .map((TimeFrame timeFrame) => DropdownMenuEntry<TimeFrame>(
              value: timeFrame, label: timeFrame.name))
          .toList(),
      onSelected: (TimeFrame? value) =>
          context.read<NewTransactionCubit>().setTimeFrame(value),
    );
  }
}

//Transaction Multiline Comment TextField
class MultilineCommentTextField extends StatelessWidget {
  const MultilineCommentTextField({
    super.key,
    required TextEditingController commentFieldController,
  }) : _commentFieldController = commentFieldController;

  final TextEditingController _commentFieldController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: TextField(
        expands: true,
        maxLines: null,
        textAlignVertical: TextAlignVertical.top,
        controller: _commentFieldController,
        keyboardType: TextInputType.multiline,
        decoration: Styles.kTextFieldDecoration.copyWith(
          hintText: 'Write a comment',
          labelStyle: Styles.kTextFieldLabelStyle,
        ),
      ),
    );
  }
}
