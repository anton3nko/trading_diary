import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trading_diary/styles/theme_provider.dart';

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
          height: 10,
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Theme mode',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            //Добавил DropdownMenu для выбора темы приложения. Дефолтное значение = system
            Consumer<ThemeProvider>(builder: (context, provider, child) {
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
      ],
    );
  }
}
