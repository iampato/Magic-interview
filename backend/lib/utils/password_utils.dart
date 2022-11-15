import 'package:encrypt/encrypt.dart';

///
class PasswordUtils {
  /// secret
  static const String longSecret = '12345678901234567890123456789012';

  /// Encrypts a password using AES encryption
  static String encryptPassword(String password) {
    final key = Key.fromUtf8(longSecret);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }

  /// Decrypts a password using AES encryption
  static String decryptPassword(String encryptedPassword) {
    final key = Key.fromUtf8(longSecret);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt64(encryptedPassword, iv: iv);
    return decrypted;
  }
}
