// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:magic_backend/v1/user/user.dart';

class LoginResponse extends Equatable {
  final UserDbModel user;
  final String token;
  final String refreshToken;
  const LoginResponse({
    required this.user,
    required this.token,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [user, token, refreshToken];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'token': token,
      'refreshToken': refreshToken,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      user: UserDbModel.fromMap(
        (map['user'] ?? Map<String, dynamic>.from({})) as Map<String, dynamic>,
      ),
      token: (map['token'] ?? '') as String,
      refreshToken: (map['refreshToken'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
