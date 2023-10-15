sealed class LoginState {
  LoginState(this.username, this.password);
  final String username;
  final String password;
}

//State of login_screen, when username and password TextFields are empty
final class LoginInitial extends LoginState {
  LoginInitial(super.username, super.password);
}

final class LoginSuccess extends LoginState {
  LoginSuccess(super.username, super.password);
}

final class LoginFailed extends LoginState {
  LoginFailed(super.username, super.password);
}
