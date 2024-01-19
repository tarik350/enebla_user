import 'package:flutter/foundation.dart';

class User {
  final name;
  final age;
  final gender;
  final email;
  final password;
  User(
      {required this.name,
      this.age,
      this.gender,
      required this.email,
      required this.password});

  User fromJson(Map<String, dynamic> map) {
    return User(
        name: map['name'],
        age: map['age'] ?? null,
        gender: map['gender'] ?? null,
        email: map['email'],
        password: map['password']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'gender': gender,
      'age': age,
      'password': password
    };
  }
}
