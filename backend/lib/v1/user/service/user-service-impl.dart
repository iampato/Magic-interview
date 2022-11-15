
import 'package:magic_backend/utils/jwt_utils.dart';
import 'package:magic_backend/utils/password_utils.dart';
import 'package:magic_backend/v1/user/user.dart';

/// UserServiceImpl
class UserServiceImpl extends UserService {
  /// UserRepositoryImpl
  UserServiceImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Future<UserDbModel> registerUser(CreateUserReq userReq) async {
    try {
      final userReqClone = userReq.copyWith(
        password: PasswordUtils.encryptPassword(userReq.password),
      );
      // check if user already exists
      final user = await _userRepository.getUserByEmail(userReqClone.email);
      if (user != null) {
        throw Exception('User already exists');
      }
      return _userRepository.createUser(userReqClone);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginResponse> loginUser(LoginReq request) async {
    try {
      // check if user already exists
      final user = await _userRepository.getUserByEmail(request.email);
      if (user == null) {
        throw Exception('User does not exists');
      }
      if (user.password != PasswordUtils.encryptPassword(request.password)) {
        throw Exception('Invalid email address or password');
      }
      // generate token
      final claims = <String, dynamic>{
        'id': user.id,
        'email': user.email,
        'name': user.name,
      };
      final token = JWTUtils.generateToken(claims);
      final refreshToken = JWTUtils.generateRefreshToken(claims);
      // return
      return LoginResponse(
        user: user,
        token: token,
        refreshToken: refreshToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(String id) {
    try {
      return _userRepository.deleteUser(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDbModel?> getUserById(String id) {
    try {
      return _userRepository.getUserById(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDbModel> updateUser(String id, CreateUserReq userReq) {
    try {
      return _userRepository.updateUser(id, userReq);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserDbModel>> getAllUsers() {
    try {
      return _userRepository.getAllUsers();
    } catch (e) {
      rethrow;
    }
  }
}
