import 'package:magic/src/features/home/model/create_workout_request.dart';
import 'package:magic/src/features/home/model/workout_model.dart';
import 'package:magic/src/features/home/model/workout_response.dart';
import 'package:magic/src/features/landing/models/user_model.dart';
import 'package:magic/src/features/onboarding/models/login_response.dart';

UserModel mockedUser = UserModel(
  id: "1",
  name: 'Mocked User',
  email: 'muser@example.com',
  password: "12345",
);

LoginResponse mockedLoginResponse = LoginResponse(
  user: mockedUser,
  token: "token",
  refreshToken: "refreshToken",
);

CreateWorkoutRequest dummyCreateWorkoutRequest = CreateWorkoutRequest(
  type: "squat",
  weight: 100,
  noOfReps: 10,
  noOfSets: 2,
);

//List<WorkoutResponse?> dummy data
List<WorkoutResponse> dummyWorkoutResponse = [
  WorkoutResponse(
    workouts: [
      WorkoutModel(
        id: "1",
        type: "squat",
        dateCreatedAt: DateTime.now(),
        dateUpdatedAt: DateTime.now(),
        noOfReps: 1,
        noOfSets: 5,
        weight: 150,
        userId: "1",
      ),
      WorkoutModel(
        id: "2",
        type: "squat",
        dateCreatedAt: DateTime.now(),
        dateUpdatedAt: DateTime.now(),
        noOfReps: 1,
        noOfSets: 5,
        weight: 150,
        userId: "1",
      ),
    ],
    month: "January 2022",
  ),
  WorkoutResponse(
    workouts: [
      WorkoutModel(
        id: "1",
        type: "squat",
        dateCreatedAt: DateTime.now(),
        dateUpdatedAt: DateTime.now(),
        noOfReps: 1,
        noOfSets: 5,
        weight: 150,
        userId: "1",
      ),
      WorkoutModel(
        id: "2",
        type: "squat",
        dateCreatedAt: DateTime.now(),
        dateUpdatedAt: DateTime.now(),
        noOfReps: 1,
        noOfSets: 5,
        weight: 150,
        userId: "1",
      ),
    ],
    month: "January 2022",
  ),
];
