import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:trading_diary/data/api/currency_api.dart';
import 'package:trading_diary/domain/model/dashboard_data_model.dart';
import 'package:trading_diary/features/auth/presentation/bloc/login_bloc.dart';
import 'package:trading_diary/features/auth/presentation/login_screen.dart';
import 'package:trading_diary/features/currencies_list/bloc/currency_bloc.dart';
import 'package:trading_diary/features/registration_screen.dart';
import 'package:trading_diary/features/home_screen.dart';
import 'package:trading_diary/features/settings/bloc/balance_bloc.dart';
import 'package:trading_diary/features/transactions/presentation/transactions_page.dart';
import 'package:trading_diary/features/widgets/app_nav_bar/nav_bar_cubit.dart';

import 'package:trading_diary/features/strategies/presentation/strategy_add_page.dart';
import 'package:trading_diary/features/strategies/bloc/strategies_bloc.dart';
import 'package:trading_diary/features/transactions/presentation/transaction_add_page.dart';
import 'package:trading_diary/features/transactions/bloc/transaction_bloc.dart';
import 'package:trading_diary/features/transactions/bloc/new_transaction_cubit.dart';
import 'package:trading_diary/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:trading_diary/services/shared_pref_service.dart';
import 'package:trading_diary/styles/color_schemes.g.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTimeRange defaultRange = DateTimeRange(
        start: DateTime(now.year, now.month, 1),
        end: DateTime(now.year, now.month, now.day, 23, 59, 59));
    final initialDashboardData = DashboardDataModel(dateRange: defaultRange);
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(),
          ),
          BlocProvider(
            create: (context) => NavBarCubit(),
          ),
          BlocProvider(
            create: (context) => StrategyBloc()
              ..add(
                const InitialStrategyEvent(),
              ),
          ),
          BlocProvider(
            create: (context) =>
                TransactionBloc(initialDateRange: defaultRange),
          ),
          BlocProvider(
            create: (context) => NewTransactionCubit(),
          ),
          BlocProvider(
            create: (context) => DashboardBloc(
              initialDashboardData: initialDashboardData,
            )..add(
                const FetchDashboardDataEvent(),
              ),
          ),
          BlocProvider(
            create: (context) => CurrencyBloc(
              CurrencyApi(token: 'c264dae976f36d57d5720324482f1487'),
            ),
          )
        ],
        child: BlocBuilder<BalanceBloc, BalanceState>(
          builder: (context, state) {
            return Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Trading Diary',
                  theme: themeProvider.darkTheme
                      ? ThemeData(
                          useMaterial3: true,
                          colorScheme: darkColorScheme,
                        )
                      : ThemeData(
                          useMaterial3: true,
                          colorScheme: lightColorScheme,
                        ),
                  initialRoute: HomeScreen.id,
                  routes: {
                    LoginScreen.id: (context) => const LoginScreen(),
                    RegistrationScreen.id: (context) =>
                        const RegistrationScreen(),
                    HomeScreen.id: (context) => const HomeScreen(),
                    StrategyAddPage.id: (context) => const StrategyAddPage(),
                    TransactionAddPage.id: (context) =>
                        const TransactionAddPage(),
                    TransactionsPage.id: (context) => const TransactionsPage(),
                  },
                );
              },
            );
          },
        ));
  }
}
