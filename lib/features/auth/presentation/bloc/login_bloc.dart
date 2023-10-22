import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginPressedEvent) {
        emit(LoginLoading());
        await Future.delayed(const Duration(seconds: 2));
        try {
          if (event.userName == 'admin' && event.password == '123') {
            emit(LoginSuccess());
          } else {
            emit(LoginFailure('Login failed!'));
          }
        } catch (e) {
          emit(LoginFailure('Something went wrong!'));
        }
      }
    });
  }
}
