import 'package:flutter/material.dart';

class TransactionAddViewModel {
  late TextEditingController _typeFieldController;
  late TextEditingController _volumeFieldController;
  late TextEditingController _mainStrategyController;
  late TextEditingController _secStrategyController;
  late TextEditingController _timeFrameController;
  late TextEditingController _profitFieldController;
  late TextEditingController _commentFieldController;

  TextEditingController get typeFieldController => _typeFieldController;
  TextEditingController get volumeFieldController => _volumeFieldController;
  TextEditingController get mainStrategyController => _mainStrategyController;
  TextEditingController get secStrategyController => _secStrategyController;
  TextEditingController get timeFrameController => _timeFrameController;
  TextEditingController get profitFieldController => _profitFieldController;
  TextEditingController get commentFieldController => _commentFieldController;

  void initControllers() {
    _typeFieldController = TextEditingController();
    _volumeFieldController = TextEditingController();
    _mainStrategyController = TextEditingController();
    _secStrategyController = TextEditingController();
    _timeFrameController = TextEditingController();
    _profitFieldController = TextEditingController();
    _commentFieldController = TextEditingController();
  }

  void disposeControllers() {
    _typeFieldController.dispose();
    _volumeFieldController.dispose();
    _mainStrategyController.dispose();
    _secStrategyController.dispose();
    _timeFrameController.dispose();
    _profitFieldController.dispose();
    _commentFieldController.dispose();
  }
}
