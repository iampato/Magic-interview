import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

///
class JWTUtils {
  ///
  static const String secret = '01234567890123456789012345678901';

  /// generate token
  static String generateToken(Map<String, dynamic> claims) {
    final jwt = JWT(
      claims,
      issuer: 'https://api-test.com',
    );
    return jwt.sign(
      SecretKey(secret),
      expiresIn: const Duration(minutes: 120),
    );
  }

  /// generate refresh token
  static String generateRefreshToken(Map<String, dynamic> claims) {
    final jwt = JWT(
      claims,
      issuer: 'https://api-test.com',
    );
    return jwt.sign(
      SecretKey(secret),
      expiresIn: const Duration(days: 30),
    );
  }

  /// check if the JWT is okay
  static bool isJwtValid(String token) {
    try {
      JWT.verify(token, SecretKey(secret));
      return true;
      // ignore: avoid_catching_errors
    } on JWTExpiredError {
      return false;
      // ignore: avoid_catching_errors
    } on JWTError catch (_) {
      return false;
    }
  }
}
