import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:magic/src/core/http_client.dart';
import 'package:magic/src/features/landing/models/user_model.dart';
import 'package:magic/src/features/onboarding/models/login_response.dart';

class LoginRepository {
  // global variables
  final HttpNetworkUtil _httpNetworkUtil = HttpNetworkUtil();

  Future<LoginResponse?> login({
    required String emailAddress,
    required String password,
  }) async {
    String endpoint = "auth/login";
    try {
      Response response = await _httpNetworkUtil.postRequest(
        endpoint,
        {
          "email": emailAddress,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> register({
    required String emailAddress,
    required String name,
    required String password,
  }) async {
    String endpoint = "auth/register";
    try {
      Response response = await _httpNetworkUtil.postRequest(
        endpoint,
        {
          "name": name,
          "email": emailAddress,
          "password": password,
        },
      );
      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
