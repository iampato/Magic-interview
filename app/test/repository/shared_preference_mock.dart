// shared preference mock
//
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:magic/src/core/shared_preference.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/model_mock.dart';

class MockSharedPreferenceRepo extends Mock implements SharedPreferenceRepo {
  MockSharedPreferenceRepo() {
    // when save user value
    when(() => saveUserValue(any())).thenAnswer((_) async {
      final mockedUserJson = mockedUser.toJson();
      String userJson = jsonEncode(mockedUserJson);
      Map<String, Object> values = <String, Object>{'user': userJson};
      SharedPreferences.setMockInitialValues(values);
    });

    // when get user value
    when(() => getUserValue()).thenAnswer((_) async {
      String userJson = await SharedPreferences.getInstance().then((value) {
        return value.getString('user')!;
      });
      return userJson;
    });

    // when destory
    when(() => destory()).thenAnswer((_) async => {});
  }
}
