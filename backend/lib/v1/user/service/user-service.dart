import 'package:magic_backend/v1/user/user.dart';

/// UserService
abstract class UserService {
  /// get all users
  Future<List<UserDbModel>> getAllUsers();

  /// get user by id
  Future<UserDbModel?> getUserById(String id);

  /// get user by email
  Future<LoginResponse> loginUser(LoginReq request);

  /// create user
  Future<UserDbModel> registerUser(CreateUserReq userReq);

  /// update user
  /// [id] user id
  Future<UserDbModel> updateUser(String id, CreateUserReq userReq);

  /// delete user
  /// [id] user id
  Future<void> deleteUser(String id);
}
