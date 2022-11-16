import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreateWorkoutRequest {
  String? type;
  int? noOfSets;
  int? noOfReps;
  num? weight;
  CreateWorkoutRequest({
    this.type,
    this.noOfSets,
    this.noOfReps,
    this.weight,
  });

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
      type: map['type'] != null ? map["type"] ?? '' : null,
      noOfSets: map['noOfSets'] != null ? map["noOfSets"] ?? 0 : null,
      noOfReps: map['noOfReps'] != null ? map["noOfReps"] ?? 0 : null,
      weight: map['weight'] != null ? map["weight"] ?? 0.0 : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateWorkoutRequest.fromJson(String source) =>
      CreateWorkoutRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  CreateWorkoutRequest copyWith({
    String? type,
    int? noOfSets,
    int? noOfReps,
    num? weight,
  }) {
    return CreateWorkoutRequest(
      type: type ?? this.type,
      noOfSets: noOfSets ?? this.noOfSets,
      noOfReps: noOfReps ?? this.noOfReps,
      weight: weight ?? this.weight,
    );
  }
}
