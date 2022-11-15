// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:magic_backend/v1/workout/models/workout_db_model.dart';

// function that conver List<MyWorkoutResponse> to List<Map<String, dynamic>>
List<Map<String, dynamic>> myWorkoutResponseListToMap(
  List<MyWorkoutResponse> myWorkoutResponseList,
) {
  return myWorkoutResponseList
      .map(
        (myWorkoutResponse) => myWorkoutResponse.toMap(),
      )
      .toList();
}

/// MyWorkoutResponse
/// clusters all the workouts by month
class MyWorkoutResponse extends Equatable {
  final List<WorkoutDbModel> workouts;
  final String month;
  const MyWorkoutResponse({
    required this.workouts,
    required this.month,
  });

  @override
  List<Object?> get props => [workouts, month];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'workouts': workouts.map((x) {
        return x.toMap();
      }).toList(growable: false),
      'month': month,
    };
  }

  factory MyWorkoutResponse.fromMap(Map<String, dynamic> map) {
    return MyWorkoutResponse(
      workouts: List<WorkoutDbModel>.from(
        ((map['workouts'] ?? const <WorkoutDbModel>[]) as List)
            .map<WorkoutDbModel>((x) {
          return WorkoutDbModel.fromMap(
              (x ?? Map<String, dynamic>.from({})) as Map<String, dynamic>);
        }),
      ),
      month: (map['month'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyWorkoutResponse.fromJson(String source) =>
      MyWorkoutResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
