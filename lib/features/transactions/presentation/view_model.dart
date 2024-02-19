import 'package:flutter/material.dart';

class TransactionAddViewModel {
  late TextEditingController _typeFieldController;
  late TextEditingController _volumeFieldController;
  late TextEditingController _profitFieldController;
  late TextEditingController _commentFieldController;

  TextEditingController get typeFieldController => _typeFieldController;
  TextEditingController get volumeFieldController => _volumeFieldController;
  TextEditingController get profitFieldController => _profitFieldController;
  TextEditingController get commentFieldController => _commentFieldController;

  void initControllers() {
    _typeFieldController = TextEditingController();
    _volumeFieldController = TextEditingController();
    _profitFieldController = TextEditingController();
    _commentFieldController = TextEditingController();
  }

  void disposeControllers() {
    _typeFieldController.dispose();
    _volumeFieldController.dispose();
    _profitFieldController.dispose();
    _commentFieldController.dispose();
  }
}
