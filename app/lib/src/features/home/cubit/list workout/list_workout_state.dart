part of 'list_workout_cubit.dart';

@freezed
class ListWorkoutState with _$ListWorkoutState {
  const factory ListWorkoutState.initial() = _Initial;
  const factory ListWorkoutState.success({
    required List<WorkoutResponse?> workoutResponse,
  }) = _Success;
  const factory ListWorkoutState.error({
    required String message,
  }) = _Error;
}
