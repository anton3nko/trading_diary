part of 'login_bloc.dart';

sealed class LoginEvent {
  const LoginEvent();
}

final class LoginButtonPressed extends LoginEvent {
  LoginButtonPressed(this.username, this.password);
  final String username;
  final String password;
}

final class RegisterButtonPressed extends LoginEvent {
  const RegisterButtonPressed();
}
