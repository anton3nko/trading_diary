import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trading_diary/styles/settings_provider.dart';
import 'package:trading_diary/styles/styles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          const Align(
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  'Theme mode',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 35.0,
                ),
                //Добавил DropdownMenu для выбора темы приложения. Дефолтное значение = system
                DropdownMenu<String>(
                  initialSelection: provider.currentTheme,
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(
                      label: 'Light',
                      value: 'light',
                    ),
                    DropdownMenuEntry(
                      label: 'Dark',
                      value: 'dark',
                    ),
                    DropdownMenuEntry(
                      label: 'System',
                      value: 'system',
                    ),
                  ],
                  onSelected: (String? value) {
                    provider.changeTheme(value ?? 'system');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  'Starting Balance',
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    //FIXME Баг:
                    //1. Изменил стартовый баланс.
                    //2. На Dashboard и Settings Page он изменился.
                    //3. Перезапустил приложение.
                    //4. На Dashboard отображается измененный стартовый баланс,
                    //на Settings Page - старый/дефолтный = 1000.
                    //FIXME При запуске приложения
                    //здесь отображается дефолтное значение = 1000
                    initialValue: provider.startingBalance.toString(),
                    textAlign: TextAlign.right,
                    inputFormatters: Styles.kDoubleSignedFormat,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false,
                    ),
                    onChanged: (String? value) {
                      provider.changeBalance(int.tryParse(value!) ?? 1000);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
