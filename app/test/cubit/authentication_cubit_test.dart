// test AuthenticationCubitTest

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/src/features/landing/cubit/authentication/authentication_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../network/model_mock.dart';
import '../repository/shared_preference_mock.dart';

void main() {
  late AuthenticationCubit authenticationCubit;
  late MockSharedPreferenceRepo mockSharedPreferenceRepo;

  setUp(() {
    mockSharedPreferenceRepo = MockSharedPreferenceRepo();
    authenticationCubit = AuthenticationCubit(
      preferencesRepo: mockSharedPreferenceRepo,
    );
  });

  tearDown(() {
    authenticationCubit.close();
  });

  group('AuthenticationCubitTest ', () {
    test('initial state is AuthenticationInitial', () {
      expect(authenticationCubit.state, const AuthenticationState.initial());
    });

    // test when isUserLoggedIn is called on initial launch
    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [AuthenticationUnAuthenticated] when isUserLoggedIn is called on initial launch',
      build: () {
        when(() => mockSharedPreferenceRepo.getUserValue()).thenAnswer(
          (_) async => null,
        );
        return authenticationCubit;
      },
      act: (cubit) => cubit.isUserLoggedIn(),
      expect: () => [
        const AuthenticationState.unAuthenticated(),
      ],
    );

    // test when isUserLoggedIn is called on subsequent launch
    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [AuthenticationUnAuthenticated] when isUserLoggedIn is called on subsequent launch',
      build: () {
        when(() => mockSharedPreferenceRepo.getUserValue()).thenAnswer(
          (_) async => "user",
        );
        return authenticationCubit;
      },
      act: (cubit) => cubit.isUserLoggedIn(),
      expect: () => [
        const AuthenticationState.authenticated(),
      ],
    );

    // test when authenticateUser is called
    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [AuthenticationAuthenticated] when authenticateUser is called',
      build: () => authenticationCubit,
      act: (cubit) => cubit.authenticateUser(
        mockedUser,
      ),
      expect: () => [
        AuthenticationState.authenticated(
          userModel: mockedUser,
        ),
      ],
    );

    // when logOut is called
    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [AuthenticationUnAuthenticated] when logOut is called',
      build: () => authenticationCubit,
      act: (cubit) => cubit.logOut(),
      expect: () => [
        const AuthenticationState.unAuthenticated(),
      ],
    );
  });
}
