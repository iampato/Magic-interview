// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

///
class WorkoutDbModel extends Equatable {
  final ObjectId id;
  final String type;
  final String dateCreated;
  final String dateUpdated;
  final int noOfSets;
  final int noOfReps;
  final double weight;
  final String userId;

  const WorkoutDbModel({
    required this.id,
    required this.type,
    required this.dateCreated,
    required this.dateUpdated,
    required this.noOfSets,
    required this.noOfReps,
    required this.weight,
    required this.userId,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        dateCreated,
        dateUpdated,
        noOfSets,
        noOfReps,
        weight,
        userId,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toHexString(),
      'type': type,
      'dateCreatedAt': dateCreated,
      'dateUpdatedAt': dateUpdated,
      'noOfSets': noOfSets,
      'noOfReps': noOfReps,
      'weight': weight,
      'userId': userId,
    };
  }

  factory WorkoutDbModel.fromMap(Map<String, dynamic> map) {
    return WorkoutDbModel(
      id: map['_id'] as ObjectId,
      type: (map['type'] ?? '') as String,
      dateCreated: (map['dateCreatedAt'] ?? '') as String,
      dateUpdated: (map['dateUpdatedAt'] ?? '') as String,
      noOfSets: (map['noOfSets'] ?? 0) as int,
      noOfReps: (map['noOfReps'] ?? 0) as int,
      weight: (map['weight'] ?? 0.0) as double,
      userId: (map['userId'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkoutDbModel.fromJson(String source) =>
      WorkoutDbModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
