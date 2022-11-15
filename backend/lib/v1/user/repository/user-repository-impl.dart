import 'package:magic_backend/config/mongo-client.dart';
import 'package:magic_backend/v1/user/user.dart';
import 'package:mongo_dart/mongo_dart.dart';

/// UserRepositoryImpl class
class UserRepositoryImpl implements UserRepository {
  /// UserRepositoryImpl
  UserRepositoryImpl({
    required MongoClient mongoClient,
  }) : _mongoClient = mongoClient;

  final MongoClient _mongoClient;

  @override
  Future<UserDbModel> createUser(CreateUserReq userReq) async {
    if (_mongoClient.db != null) {
      final collection = _mongoClient.db!.collection('users');
      final results = await collection.insertOne(userReq.toMap());
      if (results.isSuccess) {
        return UserDbModel.fromMap(results.document!);
      } else {
        throw Exception(results.errmsg ?? 'an error occured in creating user');
      }
    } else {
      throw Exception('Database not connected');
    }
  }

  @override
  Future<void> deleteUser(String id) {
    if (_mongoClient.db != null) {
      final collection = _mongoClient.db!.collection('users');
      return collection.deleteOne(where.eq('_id', ObjectId.fromHexString(id)));
    } else {
      throw Exception('Database not connected');
    }
  }

  @override
  Future<UserDbModel?> getUserByEmail(String email) async {
    if (_mongoClient.db != null) {
      final collection = _mongoClient.db!.collection('users');
      final results = await collection.findOne(where.eq('email', email));
      if (results != null) {
        return UserDbModel.fromMap(results);
      } else {
        return null;
      }
    } else {
      throw Exception('Database not connected');
    }
  }

  @override
  Future<UserDbModel?> getUserById(String id) async {
    if (_mongoClient.db != null) {
      final collection = _mongoClient.db!.collection('users');
      final results = await collection.findOne(
        where.eq(
          '_id',
          ObjectId.fromHexString(id),
        ),
      );
      if (results != null) {
        return UserDbModel.fromMap(results);
      } else {
        return null;
      }
    } else {
      throw Exception('Database not connected');
    }
  }

  @override
  Future<UserDbModel> updateUser(String id, CreateUserReq userReq) async {
    if (_mongoClient.db != null) {
      final collection = _mongoClient.db!.collection('users');
      final userReqMap = userReq.toMap()..remove('password');
      final results = await collection.updateOne(
        where.eq(
          '_id',
          ObjectId.fromHexString(id),
        ),
        {
          r'$set': userReqMap,
        },
      );
      if (results.isSuccess) {
        final updatedUser = await getUserById(id);
        return updatedUser!;
      } else {
        throw Exception(results.errmsg ?? 'an error occured in updating user');
      }
    } else {
      throw Exception('Database not connected');
    }
  }

  @override
  Future<List<UserDbModel>> getAllUsers() {
    if (_mongoClient.db != null) {
      final collection = _mongoClient.db!.collection('users');
      return collection.find().map(UserDbModel.fromMap).toList();
    } else {
      throw Exception('Database not connected');
    }
  }
}
