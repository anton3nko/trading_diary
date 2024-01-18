import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:trading_diary/styles/theme_provider.dart';
import 'package:trading_diary/styles/styles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              Text(
                'Theme mode',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                width: 35.0,
              ),
              //Добавил DropdownMenu для выбора темы приложения. Дефолтное значение = system
              Consumer<SettingsProvider>(builder: (context, provider, child) {
                return DropdownMenu<String>(
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
                );
              }),
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
              Consumer<SettingsProvider>(builder: (context, provider, child) {
                return SizedBox(
                  width: 100,
                  child: TextFormField(
                    initialValue: provider.balance.toString(),
                    textAlign: TextAlign.right,
                    inputFormatters: Styles.kDoubleSignedFormat,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false,
                    ),
                    onChanged: (String? value) {
                      double newBalance = double.tryParse(value!) ?? 1000;
                      log(newBalance.toString(), name: 'changingBalance');
                      provider.changeBalance(newBalance);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
        // Row(
        //   children: [
        //     const Padding(
        //       padding: EdgeInsets.all(8.0),
        //       child: Text(
        //         'Starting Balance',
        //         style: TextStyle(
        //           fontSize: 20,
        //         ),
        //       ),
        //     ),
        //     //Добавил DropdownMenu для выбора темы приложения. Дефолтное значение = system
        //     Consumer<ThemeProvider>(builder: (context, provider, child) {
        //       return TextField();
        //       // TextFormField(
        //       //   initialValue: provider.balance.toString(),
        //       //   inputFormatters: Styles.kDoubleSignedFormat,
        //       //   keyboardType: const TextInputType.numberWithOptions(
        //       //     decimal: true,
        //       //     signed: false,
        //       //   ),
        //       //   // decoration: Styles.kTextFieldDecoration.copyWith(
        //       //   //   labelStyle: Styles.kTextFieldLabelStyle,
        //       //   //   floatingLabelBehavior: FloatingLabelBehavior.always,
        //       //   // ),
        //       //   onChanged: (value) {
        //       //     provider.changeBalance(double.parse(value));
        //       //   },
        //       // );
        //     }),
        //   ],
        // ),
      ],
    );
  }
}
