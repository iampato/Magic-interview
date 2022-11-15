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
  Future<List<WorkoutDbModel>> getAllWorkoutsById(String id) {
    try {
      return _workoutRepository.getAllWorkoutsById(id);
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
