import 'dart:math';

import 'package:intl/intl.dart';
import 'package:magic_backend/v1/workout/models/my_workout_response.dart';
import 'package:magic_backend/v1/workout/workout.dart';

/// WorkoutServiceImpl
class WorkoutServiceImpl extends WorkoutService {
  /// UserRepositoryImpl
  WorkoutServiceImpl({
    required WorkoutRepository workoutRepository,
  }) : _workoutRepository = workoutRepository;

  final WorkoutRepository _workoutRepository;

  @override
  Future<WorkoutDbModel> createWorkout(
    String userId,
    CreateWorkoutRequest workoutReq,
  ) {
    try {
      return _workoutRepository.createWorkout(userId, workoutReq);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteWorkout(String id) async {
    try {
      // check if exists
      final workout = await _workoutRepository.getWorkoutById(id);
      if (workout == null) {
        throw Exception('workout not found');
      }
      return _workoutRepository.deleteWorkout(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<WorkoutDbModel>> getAllWorkouts() {
    try {
      return _workoutRepository.getAllWorkouts();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MyWorkoutResponse>> getAllWorkoutsById(String id) async {
    try {
      final workouts = await _workoutRepository.getAllWorkoutsById(id);
      // cluster the workouts by month
      // we return a list of MyWorkoutResponse
      // each month should have a list of workouts
      final workoutsByDate = <MyWorkoutResponse>[];

      for (final element in workouts) {
        // get the month and year of the workout
        final date = DateTime.parse(element.dateCreated);
        final dateFormatted = DateFormat('MMMM yyyy').format(date);
        // check if the month and year is already in the list
        final index = workoutsByDate.indexWhere(
          (element) => element.month == dateFormatted,
        );
        if (index == -1) {
          // if not, add it
          workoutsByDate.add(
            MyWorkoutResponse(
              month: dateFormatted,
              workouts: [element],
            ),
          );
        } else {
          // if it is, add the workout to the list
          workoutsByDate[index].workouts.add(element);
        }
      }
      return workoutsByDate;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WorkoutDbModel?> getWorkoutById(String id) {
    try {
      return _workoutRepository.getWorkoutById(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WorkoutDbModel> updateWorkout(
    String id,
    CreateWorkoutRequest workoutReq,
  ) {
    try {
      return _workoutRepository.updateWorkout(id, workoutReq);
    } catch (e) {
      rethrow;
    }
  }
}
