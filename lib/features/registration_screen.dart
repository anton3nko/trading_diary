import 'package:flutter/material.dart';
import '../styles.dart';
import 'widgets/rounded_button.dart';

class RegistrationScreen extends StatelessWidget {
  static final String id = 'registration_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      buttonName: 'Register',
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RoundedButton(
                      buttonColor: kYellowColor,
                      textColor: kBlackColor,
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
