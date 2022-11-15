// ignore_for_file: sort_constructors_first, public_member_api_docs
import 'dart:convert';

import 'package:equatable/equatable.dart';

/// CreateUserReq
class CreateUserReq extends Equatable {
  const CreateUserReq({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;

  CreateUserReq copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return CreateUserReq(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory CreateUserReq.fromMap(Map<String, dynamic> map) {
    return CreateUserReq(
      name: (map['name'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      password: (map['password'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateUserReq.fromJson(String source) =>
      CreateUserReq.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CreateUserReq(name: $name, email: $email, password: $password)';

  @override
  List<Object?> get props => [name, email, password];
}
