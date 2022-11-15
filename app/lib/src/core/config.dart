import 'package:flutter/foundation.dart';

class AppConfig {
  final String apiUrl;
  AppConfig({
    required this.apiUrl,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) => AppConfig(
        apiUrl: json["apiUrl"],
      );

  Map<String, dynamic> toJson() => {
        "apiUrl": apiUrl,
      };

  factory AppConfig.getProd() {
    return AppConfig(
      apiUrl: "https://magic-api-452.herokuapp.com",
    );
  }

  factory AppConfig.getDev() {
    return AppConfig(
      apiUrl: "http://192.168.100.33:8080/",
    );
  }

  factory AppConfig.getConfig() {
    if (kDebugMode == true) {
      return AppConfig.getDev();
    } else {
      return AppConfig.getProd();
    }
  }
}
