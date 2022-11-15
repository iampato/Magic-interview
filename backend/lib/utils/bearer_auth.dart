import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

/// A Bearer authentication scheme.

Middleware bearerAuthentication<User extends Object>({
  required UserFromToken<User> retrieveUser,
}) {
  return (handler) {
    return (context) async {
      final authHeader = context.request.headers['Authorization'];

      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
        return Response(statusCode: HttpStatus.badRequest);
      }

      try {
        final token = authHeader.split(' ')[1];
        final user = await retrieveUser(context, token);

        if (user == null) {
          return Response(statusCode: HttpStatus.unauthorized);
        }

        return await handler(context.provide(() => user));
      } on Exception {
        return Response(statusCode: HttpStatus.badRequest);
      }
    };
  };
}

///
typedef UserFromToken<User extends Object> = Future<User?> Function(
  RequestContext context,
  String token,
);
