import 'package:magic_backend/v1/workout/workout.dart';

/// WorkoutServiceImpl
class WorkoutServiceImpl extends WorkoutService {
  /// UserRepositoryImpl
  WorkoutServiceImpl({
    required WorkoutRepository workoutRepository,
  }) : _workoutRepository = workoutRepository;

  final WorkoutRepository _workoutRepository;

  @override
  Future<WorkoutDbModel> createWorkout(CreateWorkoutRequest workoutReq) {
    try {
      return _workoutRepository.createWorkout(workoutReq);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteWorkout(String id) {
    try {
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
