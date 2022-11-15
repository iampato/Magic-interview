import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:magic_backend/v1/user/user.dart';

// reponse handler
Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      // /v1/workout
      // GET all workouts
      return _get(context);
    case HttpMethod.post:
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
