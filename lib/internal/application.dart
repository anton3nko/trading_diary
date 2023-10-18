import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/features/auth/presentation/bloc/login_bloc.dart';
import 'package:trading_diary/features/auth/presentation/login_screen.dart';
import 'package:trading_diary/features/registration_screen.dart';
import 'package:trading_diary/features/home_screen.dart';

//TODO Куда переместить данный файл в структуре из статьи https://habr.com/ru/articles/733960/#folders_structure

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trading Diary',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomeScreen.id,
      routes: {
        LoginScreen.id: (context) => BlocProvider(
              create: (context) => LoginBloc(),
              child: const LoginScreen(),
            ),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
      },
    );
  }
}
