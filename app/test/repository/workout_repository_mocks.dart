import 'package:magic/src/features/home/repository/workout_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../network/model_mock.dart';

class MockWorkoutRepository extends Mock implements WorkoutRepository {
  MockWorkoutRepository() {
    // when getWorkouts
    when(() => getMyWorkouts(userId: any(named: 'userId')))
        .thenAnswer((_) async => []);

    // when createWorkout
    when(() => createWorkout(
        userId: any(named: 'userId'),
        request: dummyCreateWorkoutRequest)).thenAnswer((_) async => null);

    // when updateWorkout
    when(() => updateWorkout(
        workoutId: any(named: 'workoutId'),
        request: dummyCreateWorkoutRequest)).thenAnswer((_) async => null);

    // when deleteWorkout
    when(() => deleteWorkout(
          workoutId: any(named: 'workoutId'),
        )).thenAnswer((_) async => null);
  }
}
