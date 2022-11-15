import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:magic/src/core/http_client.dart';
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
        Logger().wtf("Good morning");
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
