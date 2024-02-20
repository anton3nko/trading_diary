import 'package:flutter/material.dart';

class TransactionAddViewModel {
  late TextEditingController _typeFieldController;
  late TextEditingController _volumeFieldController;
  late TextEditingController _profitFieldController;
  late TextEditingController _commentFieldController;
  late TextEditingController _openDateController;
  late TextEditingController _closeDateController;

  TextEditingController get typeFieldController => _typeFieldController;
  TextEditingController get volumeFieldController => _volumeFieldController;
  TextEditingController get profitFieldController => _profitFieldController;
  TextEditingController get commentFieldController => _commentFieldController;
  TextEditingController get openDateController => _openDateController;
  TextEditingController get closeDateController => _closeDateController;

  void initControllers() {
    _typeFieldController = TextEditingController();
    _volumeFieldController = TextEditingController();
    _profitFieldController = TextEditingController();
    _commentFieldController = TextEditingController();
    _openDateController = TextEditingController();
    _closeDateController = TextEditingController();
  }

  void disposeControllers() {
    _typeFieldController.dispose();
    _volumeFieldController.dispose();
    _profitFieldController.dispose();
    _commentFieldController.dispose();
    _openDateController.dispose();
    _closeDateController.dispose();
  }
}
