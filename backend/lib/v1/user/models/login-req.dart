// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginReq extends Equatable {
  final String email;
  final String password;

  const LoginReq({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory LoginReq.fromMap(Map<String, dynamic> map) {
    return LoginReq(
      email: (map['email'] ?? '') as String,
      password: (map['password'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginReq.fromJson(String source) =>
      LoginReq.fromMap(json.decode(source) as Map<String, dynamic>);
}
