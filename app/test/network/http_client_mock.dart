import 'package:dio/dio.dart';
import 'package:magic/src/core/http_client.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpNetworkUtil extends Mock implements HttpNetworkUtil {
  MockHttpNetworkUtil() {
    // when getRequest
    when(() => getRequest(any())).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: '/'),
          data: {},
          statusCode: 200,
        ));
    // when postRequest
    when(() => postRequest(any(), any())).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: '/'),
          data: {},
          statusCode: 200,
        ));

    // when addInterceptors
    when(() => addInterceptors()).thenAnswer((_) async => Dio());

    // when patchRequest
    when(() => patchRequest(any(), any())).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: '/'),
          data: {},
          statusCode: 200,
        ));

    // when deleteRequest
    when(() => deleteRequest(any())).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: '/'),
          data: {},
          statusCode: 200,
        ));
  }
}
