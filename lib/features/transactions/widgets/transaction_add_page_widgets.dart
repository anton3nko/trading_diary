part of 'package:trading_diary/features/transactions/presentation/transaction_add_page.dart';

//Customizable Numeric TextField for Transaction Add Page
//FIXME Перестали вводится отрицательные числа в Profit field
//Copy-paste отрицательных чисел работает,
//не вводится знак минуса с клавиатуры телефона.
/// Ответ: у меня на эмуляторе всё норм работает. Попробуй глянуть, какие ты используешь inputFormatters и что там за символы разрешаешь
class NumericTextField extends StatelessWidget {
  const NumericTextField({
    super.key,
    required TextEditingController numericFieldController,
    required List<TextInputFormatter> inputFormatters,
    required bool isSigned,
    required String hintText,
    required String label,
    required bool isRequired,
  })  : _numericFieldController = numericFieldController,
        _inputFormatters = inputFormatters,
        _isSigned = isSigned,
        _hintText = hintText,
        _label = label,
        _isRequired = isRequired;

  final TextEditingController _numericFieldController;
  final List<TextInputFormatter> _inputFormatters;
  final bool _isSigned;
  final String _hintText;
  final String _label;
  final bool _isRequired;

  @override
  Widget build(BuildContext context) {
    String requiredSymbol = _isRequired ? '*' : '';
    return TextField(
      inputFormatters: _inputFormatters,
      controller: _numericFieldController,
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
        signed: _isSigned,
      ),
      decoration: Styles.kTextFieldDecoration.copyWith(
        hintText: _hintText,
        label: Text('$requiredSymbol$_label'),
        labelStyle: Styles.kTextFieldLabelStyle,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: (value) {
        log(value);
      },
    );
  }
}

//Transaction Types List Dropdown Menu
class TrTypeDropdownMenu extends StatelessWidget {
  const TrTypeDropdownMenu({
    super.key,
    required TextEditingController typeFieldController,
  }) : _typeFieldController = typeFieldController;

  final TextEditingController _typeFieldController;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<TransactionType>(
      hintText: '*Buy/Sell',
      label: const Text('*Buy/Sell'),
      controller: _typeFieldController,
      initialSelection: TransactionType.buy,
      dropdownMenuEntries: const [
        DropdownMenuEntry<TransactionType>(
            value: TransactionType.buy, label: 'Buy'),
        DropdownMenuEntry<TransactionType>(
            value: TransactionType.sell, label: 'Sell'),
      ],
    );
  }
}

//Transaction Currencies List Dropdown Menu
class TrCurrencyDropdownMenu extends StatelessWidget {
  const TrCurrencyDropdownMenu({
    super.key,
    required this.currencies,
    required TextEditingController currencyFieldController,
  }) : _currencyFieldController = currencyFieldController;

  final List<CurrencyPair> currencies;
  final TextEditingController _currencyFieldController;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<CurrencyPair>(
      initialSelection: currencies.first,
      controller: _currencyFieldController,
      label: const Text('*Currency'),
      dropdownMenuEntries: currencies
          .map<DropdownMenuEntry<CurrencyPair>>((CurrencyPair currency) =>
              DropdownMenuEntry<CurrencyPair>(
                  value: currency, label: currency.currencyPairTitle))
          .toList(),
    );
  }
}

//Transaction TimeFrame Dropdown Menu
class TrTimeFrameDropdownMenu extends StatelessWidget {
  const TrTimeFrameDropdownMenu({
    super.key,
    required TextEditingController timeFrameController,
  }) : _timeFrameController = timeFrameController;

  final TextEditingController _timeFrameController;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<TimeFrame>(
      initialSelection: TimeFrame.m1,
      controller: _timeFrameController,
      label: const Text('*TimeFrame'),
      dropdownMenuEntries: TimeFrame.values
          .map((TimeFrame timeFrame) => DropdownMenuEntry<TimeFrame>(
              value: timeFrame, label: timeFrame.name))
          .toList(),
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
    return TextField(
      controller: _commentFieldController,
      keyboardType: TextInputType.multiline,
      decoration: Styles.kTextFieldDecoration.copyWith(
        hintText: 'Comment',
        label: const Text('Comment'),
        labelStyle: Styles.kTextFieldLabelStyle,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
