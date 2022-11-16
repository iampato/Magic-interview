// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateWorkoutRequest extends Equatable {
  final String type;
  final int noOfSets;
  final int noOfReps;
  final num weight;
  const CreateWorkoutRequest({
    required this.type,
    required this.noOfSets,
    required this.noOfReps,
    required this.weight,
  });
  @override
  List<Object?> get props => [
        type,
        noOfSets,
        noOfReps,
        weight,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'noOfSets': noOfSets,
      'noOfReps': noOfReps,
      'weight': weight,
    };
  }

  factory CreateWorkoutRequest.fromMap(Map<String, dynamic> map) {
    return CreateWorkoutRequest(
      type: (map['type'] ?? '') as String,
      noOfSets: (map['noOfSets'] ?? 0) as int,
      noOfReps: (map['noOfReps'] ?? 0) as int,
      weight: (map['weight'] ?? 0.0) as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateWorkoutRequest.fromJson(String source) =>
      CreateWorkoutRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
