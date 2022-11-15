import 'package:dart_frog/dart_frog.dart';
import 'package:magic_backend/config/mongo-client.dart';
import 'package:magic_backend/v1/user/user.dart';
import 'package:magic_backend/v1/workout/workout.dart';

/// Middleware
Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(serviceProvider())
      .use(repoProvider());
}

Middleware repoProvider() {
  return provider<WorkoutRepositoryImpl>(
    (context) => WorkoutRepositoryImpl(
      mongoClient: context.read<MongoClient>(),
    ),
  );
}

Middleware serviceProvider() {
  return provider<UserServiceImpl>(
    (context) => UserServiceImpl(
      userRepository: context.read<UserRepositoryImpl>(),
    ),
  );
}
