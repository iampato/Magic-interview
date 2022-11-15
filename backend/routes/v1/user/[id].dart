import 'dart:io';

import 'package:magic_backend/v1/user/user.dart';
import 'package:dart_frog/dart_frog.dart';

// reponse handler
Future<Response> onRequest(RequestContext context, String id) async {
  switch (context.request.method) {
    case HttpMethod.get:
      // /v1/user/:id
      // GET  user by id
      return _get(context, id);
    case HttpMethod.patch:
      // /v1/user/:id
      // PATCH create a user
      return _patch(context, id);
    case HttpMethod.delete:
      // /v1/user/:id
      // DELETE delete a user
      return _delete(context, id);
    case HttpMethod.post:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.put:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context, String id) async {
  try {
    final userServiceImpl = context.read<UserServiceImpl>();

    final user = await userServiceImpl.getUserById(id);
    return Response.json(body: user?.toMap());
  } catch (e) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}

Future<Response> _patch(RequestContext context, String id) async {
  try {
    final userServiceImpl = context.read<UserServiceImpl>();
    final requestJson = await context.request.json() as Map<String, dynamic>?;
    if (requestJson == null) {
      return Response(statusCode: HttpStatus.badRequest);
    }
    final userRequest = CreateUserReq.fromMap(requestJson);
    final userResponse = await userServiceImpl.updateUser(id, userRequest);
    final userMap = userResponse.toMap()..remove('password');
    return Response.json(
      body: userMap,
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

Future<Response> _delete(RequestContext context, String id) async {
  try {
    final userServiceImpl = context.read<UserServiceImpl>();
    await userServiceImpl.deleteUser(id);
    return Response.json(body: {'message': 'user deleted'});
  } catch (e) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}
