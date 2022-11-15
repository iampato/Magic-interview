import 'dart:io';

import 'package:magic_backend/v1/user/user.dart';
import 'package:dart_frog/dart_frog.dart';

// reponse handler
Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      // /v1/user
      // GET all users
      return _get(context);
    case HttpMethod.post:
      // /v1/user
      // POST create a user
      return _post(context);
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.put:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context) async {
  try {
    final userServiceImpl = context.read<UserServiceImpl>();
    final userResponse = await userServiceImpl.getAllUsers();

    return Response.json(
      statusCode: HttpStatus.created,
      body: userModelListToMapList(userResponse),
    );
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.internalServerError,
      body: {
        'message': e.toString(),
      },
    );
  }
}

Future<Response> _post(RequestContext context) async {
  try {
    final userServiceImpl = context.read<UserServiceImpl>();
    final requestJson = await context.request.json() as Map<String, dynamic>?;
    if (requestJson == null) {
      return Response(statusCode: HttpStatus.badRequest);
    }
    final userRequest = CreateUserReq.fromMap(requestJson);
    final userResponse = await userServiceImpl.registerUser(userRequest);

    return Response.json(
      statusCode: HttpStatus.created,
      body: userResponse.toMap(),
    );
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.internalServerError,
      body: {
        'message': e.toString(),
      },
    );
  }
}
