import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magic/src/features/home/model/workout_response.dart';
import 'package:magic/src/features/home/repository/workout_repository.dart';

part 'list_workout_state.dart';
part 'list_workout_cubit.freezed.dart';

class ListWorkoutCubit extends Cubit<ListWorkoutState> {
  final WorkoutRepository workoutRepo;
  ListWorkoutCubit({
    required this.workoutRepo,
  }) : super(const ListWorkoutState.initial());

  /// get all workouts
  Future<void> getMyWorkouts({
    required String userId,
  }) async {
    try {
      final workoutResponse = await workoutRepo.getMyWorkouts(userId: userId);
      emit(ListWorkoutState.success(workoutResponse: workoutResponse));
    } catch (e) {
      emit(ListWorkoutState.error(message: e.toString()));
    }
  }
}
