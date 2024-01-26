import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_new/bloc/auth/auth_event.dart';
import 'package:enebla_new/bloc/auth/auth_state.dart';
import 'package:enebla_new/data/repositories/auth_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enebla_new/data/models/user.dart' as model;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authRepository = AuthRepository();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  FutureOr<void> _register(
      AuthRegisterEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);

      String photoUrl = await _authRepository.uploadImgeToStorage(
          'profilePics', event.photoUrl);

      model.User user = model.User(
          firstname: event.firstname,
          uid: _auth.currentUser!.uid,
          lastname: event.lastname,
          email: event.email,
          phonenumber: event.phonenumber,
          address: event.address,
          photoUrl: photoUrl);

      await _firestore.collection('users').doc(credential.user!.uid).set(
            user.toJson(),
          );
    } catch (e) {
      emit(AuthErrorState(message: "Some Error occured :${e.toString()}"));
    }
  }
}
