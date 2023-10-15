part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginPressedEvent extends LoginEvent {
  final String userName;
  final String password;
  LoginPressedEvent(this.userName, this.password);
}
