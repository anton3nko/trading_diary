part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginPressedEvent extends LoginEvent {
  final String userName;
  final String password;
  LoginPressedEvent(this.userName, this.password);
}

//TODO где обработать данный ивент?
class SignUpPressedEvent extends LoginEvent {
  SignUpPressedEvent();
}
