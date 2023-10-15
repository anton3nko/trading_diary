part of 'login_bloc.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  // final String userName;
  // LoginSuccess(this.userName);
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}
