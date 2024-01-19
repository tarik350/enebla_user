import 'package:flutter/material.dart';

abstract class AuthEvent {}

class AuthRegisterEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;
  AuthLoginEvent({required this.email, required this.password});
}
