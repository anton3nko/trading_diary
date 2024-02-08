import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/data/api/currency_api.dart';
import 'package:trading_diary/features/auth/presentation/bloc/login_bloc.dart';
import 'package:trading_diary/features/auth/presentation/login_screen.dart';
import 'package:trading_diary/features/currencies_list/bloc/currency_bloc.dart';
import 'package:trading_diary/features/registration_screen.dart';
import 'package:trading_diary/features/home_screen.dart';
import 'package:trading_diary/features/transactions/presentation/transactions_page.dart';
import 'package:trading_diary/features/widgets/app_nav_bar/nav_bar_cubit.dart';
import 'package:provider/provider.dart';

import 'package:trading_diary/styles/settings_provider.dart';
import 'package:trading_diary/features/strategies/presentation/strategy_add_page.dart';
import 'package:trading_diary/features/strategies/bloc/strategies_bloc.dart';
import 'package:trading_diary/features/transactions/presentation/transaction_add_page.dart';
import 'package:trading_diary/features/transactions/bloc/transaction_bloc.dart';
import 'package:trading_diary/features/transactions/bloc/new_transaction_cubit.dart';
import 'package:trading_diary/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:trading_diary/features/settings/bloc/balance_bloc.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => NavBarCubit()),
        BlocProvider(
            create: (context) =>
                StrategyBloc()..add(const InitialStrategyEvent())),
        BlocProvider(
            //TODO ..add(const InitBalanceEvent())) вот так проинициализировать не получается
            //Если я правильно понял, обработчик ивентов в блоке находится в теле конструктора,
            //а если использовать поля с модификатором late, то требуется, чтобы они были инициализированы
            //до выполнения тела конструктора BalanceBloc()
            //p.s. Сейчас ошибки late initialize нет, я как-то починил, но забыл как :)
            create: (context) => BalanceBloc()..add(const InitBalanceEvent())),
        BlocProvider(create: (context) => TransactionBloc()),
        BlocProvider(create: (context) => NewTransactionCubit()),
        BlocProvider(create: (context) => DashboardBloc()),
        BlocProvider(
          create: (context) => CurrencyBloc(
            CurrencyApi(token: 'c264dae976f36d57d5720324482f1487'),
          ),
        )
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Trading Diary',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            // darkTheme: ThemeData.dark(),
            // themeMode: provider.themeMode,
            initialRoute: HomeScreen.id,
            routes: {
              LoginScreen.id: (context) => const LoginScreen(),
              RegistrationScreen.id: (context) => const RegistrationScreen(),
              HomeScreen.id: (context) => const HomeScreen(),
              StrategyAddPage.id: (context) => const StrategyAddPage(),
              TransactionAddPage.id: (context) => const TransactionAddPage(),
              TransactionsPage.id: (context) => const TransactionsPage(),
            },
          );
        },
      ),
    );
  }
}
