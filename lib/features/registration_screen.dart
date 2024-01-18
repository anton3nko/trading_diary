import 'package:flutter/material.dart';
import '../styles/styles.dart';
import 'widgets/rounded_button.dart';

class RegistrationScreen extends StatelessWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: Styles.kTextFieldDecoration.copyWith(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  decoration: Styles.kTextFieldDecoration.copyWith(
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RoundedButton(
                      buttonColor: Styles.kBlackColor,
                      textColor: Styles.kYellowColor,
                      buttonName: 'Register',
                      onPressed: () {},
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    RoundedButton(
                      buttonColor: Styles.kYellowColor,
                      textColor: Styles.kBlackColor,
                      buttonName: 'Back',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
