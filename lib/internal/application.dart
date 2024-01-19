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

import 'package:trading_diary/styles/theme_provider.dart';
import 'package:trading_diary/features/strategies/presentation/strategy_add_page.dart';
import 'package:trading_diary/features/strategies/bloc/strategies_bloc.dart';
import 'package:trading_diary/features/transactions/presentation/transaction_add_page.dart';
import 'package:trading_diary/features/transactions/bloc/transaction_bloc.dart';
import 'package:trading_diary/features/transactions/bloc/new_transaction_cubit.dart';
import 'package:trading_diary/features/dashboard/bloc/dashboard_bloc.dart';

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
        BlocProvider(create: (context) => TransactionBloc()),
        BlocProvider(create: (context) => NewTransactionCubit()),
        BlocProvider(create: (context) => DashboardBloc()),
        BlocProvider(
          create: (context) => CurrencyBloc(
            CurrencyApi(token: 'f5c04ab3188fabd49034b54421ae3182'),
          ),
        )
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Trading Diary',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: provider.themeMode,
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
