import 'package:magic_backend/v1/user/user.dart';

/// UserRepository
abstract class UserRepository {
  /// get all users
  Future<List<UserDbModel>> getAllUsers();

  /// get user by id
  Future<UserDbModel?> getUserById(String id);

  /// get user by email
  Future<UserDbModel?> getUserByEmail(String email);

  /// create user
  Future<UserDbModel> createUser(CreateUserReq userReq);

  /// update user
  /// [id] user id
  Future<UserDbModel> updateUser(String id, CreateUserReq userReq);

  /// delete user
  /// [id] user id
  Future<void> deleteUser(String id);
}
