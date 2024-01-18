import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/features/auth/presentation/bloc/login_bloc.dart';
import 'package:trading_diary/features/home_screen.dart';
import 'package:trading_diary/features/registration_screen.dart';
import '../../../styles/styles.dart';
import '../../widgets/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();

  @override
  void dispose() {
    emailFieldController.dispose();
    passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: Styles.kTextFieldDecoration.copyWith(
                        hintText: 'Email',
                      ),
                      controller: emailFieldController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: Styles.kTextFieldDecoration.copyWith(
                        hintText: 'Password',
                      ),
                      controller: passwordFieldController,
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
                          buttonName: 'Log in',
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context).add(
                              LoginPressedEvent(
                                emailFieldController.text,
                                passwordFieldController.text,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        RoundedButton(
                          buttonColor: Styles.kYellowColor,
                          textColor: Styles.kBlackColor,
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
                          color: Styles.kBlackColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Center(
                        child: state is LoginLoading
                            ? const CircularProgressIndicator()
                            : Container(),
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
