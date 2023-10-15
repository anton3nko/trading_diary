import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/features/auth/presentation/bloc/login_bloc.dart';
import 'package:trading_diary/features/home_screen.dart';
import 'package:trading_diary/features/registration_screen.dart';
import '../../../styles.dart';
import '../../widgets/rounded_button.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller1 = TextEditingController();
    final TextEditingController controller2 = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushNamed(context, HomeScreen.id);
              }
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                log('LoginLoading');
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Email',
                      ),
                      controller: controller1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Password',
                      ),
                      controller: controller2,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RoundedButton(
                          buttonColor: kBlackColor,
                          textColor: kYellowColor,
                          buttonName: 'Log in',
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context).add(
                              LoginPressedEvent(
                                controller1.text,
                                controller2.text,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
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
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: kBlackColor,
                        ),
                      ),
                    ),
                  ]);
            },
          ),
        ),
      ),
    );
  }
}
