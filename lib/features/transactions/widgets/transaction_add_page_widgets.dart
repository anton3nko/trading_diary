part of 'package:trading_diary/features/transactions/presentation/transaction_add_page.dart';

extension StringExtension on String {
  // Преобразует строку 'word'.capitalize => 'Word';
  String capitalize() =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
}

//TODO Попробовать использовать эти же виджеты на TransactionEditPage
//Customizable Numeric TextField for Transaction Add Page
class NumericTextField extends StatefulWidget {
  const NumericTextField({
    super.key,
    this.initialValue,
    required TextEditingController numericFieldController,
    required List<TextInputFormatter> inputFormatters,
    required String hintText,
    required bool isRequired,
  })  : _numericFieldController = numericFieldController,
        _inputFormatters = inputFormatters,
        _hintText = hintText;

  final String _hintText;
  final List<TextInputFormatter> _inputFormatters;
  final TextEditingController _numericFieldController;
  final String? initialValue;

  @override
  State<NumericTextField> createState() => _NumericTextFieldState();
}

class _NumericTextFieldState extends State<NumericTextField> {
  @override
  void initState() {
    widget._numericFieldController.text =
        widget.initialValue == 'null' ? '' : widget.initialValue!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget._inputFormatters,
      controller: widget._numericFieldController,
      keyboardType: TextInputType.phone,
      decoration: Styles.kTextFieldDecoration.copyWith(
        hintText: widget._hintText,
        labelStyle: Styles.kTextFieldLabelStyle,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

//Transaction Type Choice Chips
// ignore: must_be_immutable
class TrTypeChoiceChips extends StatefulWidget {
  TrTypeChoiceChips({super.key, this.selectedIndex});
  int? selectedIndex;
  @override
  State<TrTypeChoiceChips> createState() => _TrTypeChoiceChipsState();
}

class _TrTypeChoiceChipsState extends State<TrTypeChoiceChips> {
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
              selected: widget.selectedIndex == index,
              onSelected: (value) {
                setState(() {
                  widget.selectedIndex = value ? index : null;
                });
                if (widget.selectedIndex != null) {
                  context.read<NewTransactionCubit>().setTransactionType(
                      TransactionType.values[widget.selectedIndex!]);
                }
              },
            ),
          );
        },
      ).toList(),
    );
  }
}

//Transaction Currencies List Dropdown Menu
class TrCurrencyDropdownMenu extends StatelessWidget {
  const TrCurrencyDropdownMenu({
    super.key,
    required this.currencies,
    this.initialSelection,
  });

  final List<CurrencyPair> currencies;
  final CurrencyPair? initialSelection;
  @override
  Widget build(BuildContext context) {
    log('$initialSelection');
    return DropdownMenu<CurrencyPair>(
      initialSelection: currencies.firstWhere((element) =>
          element.currencyPairTitle == initialSelection?.currencyPairTitle),
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
  const TrTimeFrameDropdownMenu({super.key, this.initialSelection});

  final TimeFrame? initialSelection;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<TimeFrame>(
      initialSelection: initialSelection,
      expandedInsets: EdgeInsets.zero,
      hintText: '*TimeFrame',
      textStyle: Styles.kTextFieldLabelStyle,
      inputDecorationTheme: Styles.kDropdownMenuTheme,
      dropdownMenuEntries: TimeFrame.values
          .map((TimeFrame timeFrame) => DropdownMenuEntry<TimeFrame>(
                value: timeFrame,
                label: timeFrame.name,
              ))
          .toList(),
      onSelected: (TimeFrame? value) =>
          context.read<NewTransactionCubit>().setTimeFrame(value),
    );
  }
}

//Transaction Multiline Comment TextField
class MultilineCommentTextField extends StatefulWidget {
  const MultilineCommentTextField({
    super.key,
    required TextEditingController commentFieldController,
    this.initialText,
  }) : _commentFieldController = commentFieldController;

  final String? initialText;
  final TextEditingController _commentFieldController;

  @override
  State<MultilineCommentTextField> createState() =>
      _MultilineCommentTextFieldState();
}

class _MultilineCommentTextFieldState extends State<MultilineCommentTextField> {
  @override
  void initState() {
    widget._commentFieldController.text = widget.initialText ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: TextFormField(
        expands: true,
        maxLines: null,
        textAlignVertical: TextAlignVertical.top,
        controller: widget._commentFieldController,
        keyboardType: TextInputType.multiline,
        decoration: Styles.kTextFieldDecoration.copyWith(
          hintText: 'Write a comment',
          labelStyle: Styles.kTextFieldLabelStyle,
        ),
      ),
    );
  }
}
