import 'dart:async';

import 'package:enebla_new/bloc/auth/auth_event.dart';
import 'package:enebla_new/bloc/auth/auth_state.dart';
import 'package:enebla_new/data/repositories/auth_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authRepository = AuthRepository();
  AuthBloc() : super(AuthInitialState()) {
    on<AuthLoginEvent>(_login);
    on<AuthRegisterEvent>(_register);
  }

  FutureOr<void> _login(AuthLoginEvent event, Emitter<AuthState> emit) {
    emit(AuthLoadingState());
    try {
      final response =
          _authRepository.login(email: event.email, password: event.password);
      print(response);
      emit(AuthSuccessState());
      // if (event.email.isNotEmpty || event.password.isNotEmpty) {

      // } else {}
    } on FirebaseAuthException catch (err) {
      if (err.code == 'wrong-password') {
        //do something here
        emit(AuthErrorState(message: "Wrong password please try again"));
      }
    } catch (err) {
      emit(AuthErrorState(message: "Error occurred : ${err.toString()}"));
    }
  }

  FutureOr<void> _register(AuthRegisterEvent event, Emitter<AuthState> emit) {}
}
