import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/features/auth/presentation/bloc/login_bloc.dart';
import 'package:trading_diary/features/auth/presentation/login_screen.dart';
import 'package:trading_diary/features/registration_screen.dart';
import 'package:trading_diary/features/home_screen.dart';
import 'package:trading_diary/features/widgets/app_nav_bar/nav_bar_cubit.dart';
import 'package:provider/provider.dart';
import 'package:trading_diary/styles/theme_provider.dart';
import 'package:trading_diary/features/strategies/strategy_add_page.dart';
import 'package:trading_diary/features/strategies/data/bloc/strategies_bloc.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => NavBarCubit()),
        BlocProvider(create: (context) => StrategyBloc()),
      ],
      child: Consumer<ThemeProvider>(
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
            },
          );
        },
      ),
    );
  }
}

// return Consumer<ThemeProvider>(
//       builder: (context, provider, child) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Trading Diary',
//           theme: ThemeData.light(),
//           darkTheme: ThemeData.dark(),
//           themeMode: provider.themeMode,
//           initialRoute: HomeScreen.id,
//           routes: {
//             LoginScreen.id: (context) => BlocProvider(
//                   create: (context) => LoginBloc(),
//                   child: const LoginScreen(),
//                 ),
//             RegistrationScreen.id: (context) => const RegistrationScreen(),
//             HomeScreen.id: (context) => BlocProvider<NavBarCubit>(
//                   create: (context) => NavBarCubit(),
//                   child: const HomeScreen(),
//                 ),
//             StrategyAddPage.id: (context) => const StrategyAddPage(),
//           },
//         );
//       },
//     );