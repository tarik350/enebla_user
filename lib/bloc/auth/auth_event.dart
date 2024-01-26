import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent {}

class AuthRegisterEvent extends AuthEvent {
  final String phonenumber;
  final String email;
  final String address;
  final String firstname;
  final String lastname;
  final Uint8List photoUrl;
  final String password;
  AuthRegisterEvent(
      {required this.password,
      required this.phonenumber,
      required this.email,
      required this.address,
      required this.firstname,
      required this.lastname,
      required this.photoUrl});
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;
  AuthLoginEvent({required this.email, required this.password});
}
