// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

// function that conver List<UserDbModel> to List<Map<String, dynamic>>
List<Map<String, dynamic>> userModelListToMapList(List<UserDbModel> list) {
  return list.map((e) => e.toMap()).toList();
}

/// UserDbModel
class UserDbModel extends Equatable {
  const UserDbModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });
  factory UserDbModel.fromJson(String source) =>
      UserDbModel.fromMap(json.decode(source) as Map<String, dynamic>);

  /// fromMap
  factory UserDbModel.fromMap(Map<String, dynamic> map) {
    return UserDbModel(
      id: map['_id'] as ObjectId,
      name: (map['name'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      password: (map['password'] ?? '') as String,
    );
  }

  final ObjectId id;
  final String name;
  final String email;
  final String password;

  String toJson() => json.encode(toMap());

  UserDbModel copyWith({
    ObjectId? id,
    String? name,
    String? email,
    String? password,
  }) {
    return UserDbModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toHexString(),
      'name': name,
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'UserDbModel(id: $id, name: $name, email: $email, password: $password)';
  }

  @override
  List<Object?> get props => [id, name, email, password];
}
