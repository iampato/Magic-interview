// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:magic/src/features/landing/models/user_model.dart';

class LoginResponse {
  UserModel user;
  String token;
  String refreshToken;
  LoginResponse({
    required this.user,
    required this.token,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        user: UserModel.fromJson(json["user"]),
        token: json["token"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
        "refreshToken": refreshToken,
      };

  @override
  bool operator ==(covariant LoginResponse other) {
    if (identical(this, other)) return true;

    return other.user == user &&
        other.token == token &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => user.hashCode ^ token.hashCode ^ refreshToken.hashCode;
}
