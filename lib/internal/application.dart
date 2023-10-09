import 'package:flutter/material.dart';
import 'package:trading_diary/features/login_screen.dart';
import 'package:trading_diary/features/registration_screen.dart';
import 'package:trading_diary/features/home_screen.dart';

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
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}
