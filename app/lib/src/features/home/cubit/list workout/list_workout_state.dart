part of 'list_workout_cubit.dart';

@freezed
class ListWorkoutState with _$ListWorkoutState {
  const factory ListWorkoutState.initial() = _Initial;
  const factory ListWorkoutState.success({
    bool? isLoading,
    required List<WorkoutResponse?> workoutResponse,
    String? message,
  }) = _Success;
  const factory ListWorkoutState.error({
    required String message,
  }) = _Error;
}
