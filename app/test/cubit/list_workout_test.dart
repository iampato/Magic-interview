import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/src/features/home/cubit/list%20workout/list_workout_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../network/model_mock.dart';
import '../repository/shared_preference_mock.dart';
import '../repository/workout_repository_mocks.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //ListWorkoutCubit
  late ListWorkoutCubit cubit;
  late MockWorkoutRepository workoutRepo;
  late MockSharedPreferenceRepo preferenceRepo;

  setUp(() {
    workoutRepo = MockWorkoutRepository();
    preferenceRepo = MockSharedPreferenceRepo();
    cubit = ListWorkoutCubit(
      workoutRepo: workoutRepo,
      preferenceRepo: preferenceRepo,
    );
  });

  // test initial state and list workout
  group('ListWorkoutCubit', () {
    test('initial state is ListWorkoutState.initial()', () {
      expect(cubit.state, equals(const ListWorkoutState.initial()));
    });

    // test list workout
    blocTest<ListWorkoutCubit, ListWorkoutState>(
      'testing fetch workout',
      build: () {
        when(() => workoutRepo.getMyWorkouts(
              userId: any(named: 'userId'),
            )).thenAnswer((_) async => dummyWorkoutResponse);
        return cubit;
      },
      act: (cubit) => cubit.getMyWorkouts(),
      expect: () => [
        ListWorkoutState.success(workoutResponse: dummyWorkoutResponse),
      ],
    );

    // test empty list workout
    blocTest<ListWorkoutCubit, ListWorkoutState>(
      'testing fetch workout that return empty list',
      build: () {
        when(() => workoutRepo.getMyWorkouts(
              userId: any(named: 'userId'),
            )).thenAnswer((_) async => dummyWorkoutResponse);
        return cubit;
      },
      act: (cubit) => cubit.getMyWorkouts(),
      expect: () => [
        const ListWorkoutState.success(workoutResponse: []),
      ],
    );
    // test create workout
    blocTest<ListWorkoutCubit, ListWorkoutState>(
      'testing create workout',
      build: () {
        when(() => workoutRepo.createWorkout(
              userId: any(named: 'userId'),
              request: dummyCreateWorkoutRequest,
            )).thenAnswer((_) async => null);
        return cubit;
      },
      act: (cubit) => cubit.createWorkout(
        request: dummyCreateWorkoutRequest,
      ),
      expect: () => [
        const ListWorkoutState.success(workoutResponse: []),
      ],
    );
    // test edit workout
    blocTest<ListWorkoutCubit, ListWorkoutState>(
      'testing edit workout',
      build: () {
        when(() => workoutRepo.updateWorkout(
              workoutId: any(named: 'workoutId'),
              request: dummyCreateWorkoutRequest,
            )).thenAnswer((_) async => null);
        return cubit;
      },
      act: (cubit) => cubit.editWorkout(
        workoutId: 'workoutId',
        request: dummyCreateWorkoutRequest,
      ),
      expect: () => [
        const ListWorkoutState.success(workoutResponse: []),
      ],
    );
    // test delete workout
    blocTest<ListWorkoutCubit, ListWorkoutState>(
      'testing delete workout',
      build: () {
        when(() => workoutRepo.deleteWorkout(
              workoutId: any(named: 'workoutId'),
            )).thenAnswer((_) async => null);
        return cubit;
      },
      act: (cubit) => cubit.deleteWorkout(
        workoutId: 'workoutId',
      ),
      expect: () => [
        const ListWorkoutState.success(workoutResponse: []),
      ],
    );
  });
}
