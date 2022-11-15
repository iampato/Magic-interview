import 'package:magic/src/features/home/model/workout_model.dart';

class WorkoutResponse {
  WorkoutResponse({
    required this.workouts,
    required this.month,
  });

  List<WorkoutModel> workouts;
  String month;

  factory WorkoutResponse.fromJson(Map<String, dynamic> json) =>
      WorkoutResponse(
        workouts: List<WorkoutModel>.from(json["workouts"].map(
          (x) => WorkoutModel.fromJson(x),
        )),
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "workouts": List<dynamic>.from(workouts.map((x) => x.toJson())),
        "month": month,
      };
}
