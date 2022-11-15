import 'package:dart_frog/dart_frog.dart';
import 'package:magic_backend/config/mongo-client.dart';
import 'package:magic_backend/utils/bearer_auth.dart';
import 'package:magic_backend/v1/user/user.dart';
import 'package:magic_backend/v1/workout/workout.dart';

/// Middleware
Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(serviceProvider())
      .use(repoProvider());
  // .use(authProvider());
}

// Handler authProvider(Handler handler) {
//   return handler.use(
//     bearerAuthentication<UserDbModel>(
//       retrieveUser: (context, token) async {

//         // return null;
//       },
//     ),
//   );
// }

Middleware repoProvider() {
  return provider<WorkoutRepositoryImpl>(
    (context) => WorkoutRepositoryImpl(
      mongoClient: context.read<MongoClient>(),
    ),
  );
}

Middleware serviceProvider() {
  return provider<WorkoutServiceImpl>(
    (context) => WorkoutServiceImpl(
      workoutRepository: context.read<WorkoutRepositoryImpl>(),
    ),
  );
}
