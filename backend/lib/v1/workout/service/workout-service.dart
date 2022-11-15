import 'package:magic_backend/v1/workout/models/my_workout_response.dart';
import 'package:magic_backend/v1/workout/workout.dart';

/// WorkoutService
abstract class WorkoutService {
  /// get all workouts
  Future<List<WorkoutDbModel>> getAllWorkouts();

  /// filter all workouts by user id
  Future<List<MyWorkoutResponse>> getAllWorkoutsById(String id);

  /// get workout by id
  Future<WorkoutDbModel?> getWorkoutById(String id);

  /// create workout
  Future<WorkoutDbModel> createWorkout(
    String userId,
    CreateWorkoutRequest workoutReq,
  );

  /// update workout
  /// [id] user id
  Future<WorkoutDbModel> updateWorkout(
    String id,
    CreateWorkoutRequest workoutReq,
  );

  /// delete workout
  /// [id] user id
  Future<void> deleteWorkout(String id);
}
