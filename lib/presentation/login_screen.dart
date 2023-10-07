import 'package:flutter/material.dart';
import 'package:trading_diary/presentation/registration_screen.dart';
import 'constants.dart';
import 'rounded_button.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Password',
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RoundedButton(
                      buttonColor: kBlackColor,
                      textColor: kYellowColor,
                      buttonName: 'Log in',
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RoundedButton(
                      buttonColor: kYellowColor,
                      textColor: kBlackColor,
                      buttonName: 'Sign up',
                      onPressed: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: kBlackColor,
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
