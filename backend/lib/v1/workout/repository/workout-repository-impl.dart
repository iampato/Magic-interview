
import 'package:magic_backend/config/mongo-client.dart';
import 'package:magic_backend/v1/workout/workout.dart';
import 'package:mongo_dart/mongo_dart.dart';

/// WorkoutRepositoryImpl class
class WorkoutRepositoryImpl implements WorkoutRepository {
  /// WorkoutRepositoryImpl
  WorkoutRepositoryImpl({
    required MongoClient mongoClient,
  }) : _mongoClient = mongoClient;

  final MongoClient _mongoClient;

  @override
  Future<WorkoutDbModel> createWorkout(CreateWorkoutRequest workoutReq) async {
    if (_mongoClient.db != null) {
      final collection = _mongoClient.db!.collection('workouts');
      final now = DateTime.now();
      final results = await collection.insertOne({
        ...workoutReq.toMap(),
        'dateCreatedAt': now,
        'dateUpdatedAt': now,
      });
      if (results.isSuccess) {
        return WorkoutDbModel.fromMap(results.document!);
      } else {
        throw Exception(
          results.errmsg ?? 'an error occured in creating workout',
        );
      }
    } else {
      throw Exception('Database not connected');
    }
  }

  @override
  Future<void> deleteWorkout(String id) {
    if (_mongoClient.db != null) {
      final collection = _mongoClient.db!.collection('workouts');
      return collection.deleteOne(where.eq('_id', ObjectId.fromHexString(id)));
    } else {
      throw Exception('Database not connected');
    }
  }

  @override
  Future<List<WorkoutDbModel>> getAllWorkouts() {
    if (_mongoClient.db != null) {
      final collection = _mongoClient.db!.collection('workouts');
      return collection.find().map(WorkoutDbModel.fromMap).toList();
    } else {
      throw Exception('Database not connected');
    }
  }

  @override
  Future<List<WorkoutDbModel>> getAllWorkoutsById(String id) {
    if (_mongoClient.db != null) {
      final collection = _mongoClient.db!.collection('workouts');
      return collection
          .find(where.eq('userId', id))
          .map(WorkoutDbModel.fromMap)
          .toList();
    } else {
      throw Exception('Database not connected');
    }
  }

  @override
  Future<WorkoutDbModel?> getWorkoutById(String id) async {
    if (_mongoClient.db != null) {
      final collection = _mongoClient.db!.collection('workouts');
      final results = await collection.findOne(
        where.eq(
          '_id',
          ObjectId.fromHexString(id),
        ),
      );
      if (results != null) {
        return WorkoutDbModel.fromMap(results);
      } else {
        return null;
      }
    } else {
      throw Exception('Database not connected');
    }
  }

  @override
  Future<WorkoutDbModel> updateWorkout(
    String id,
    CreateWorkoutRequest workoutReq,
  ) async {
    if (_mongoClient.db != null) {
      final collection = _mongoClient.db!.collection('workouts');
      final reqMap = workoutReq.toMap();
      final results = await collection.updateOne(
        where.eq(
          '_id',
          ObjectId.fromHexString(id),
        ),
        {
          r'$set': reqMap,
        },
      );
      if (results.isSuccess) {
        final updatedWorkout = await getWorkoutById(id);
        return updatedWorkout!;
      } else {
        throw Exception(
          results.errmsg ?? 'an error occured in updating workout',
        );
      }
    } else {
      throw Exception('Database not connected');
    }
  }
}
