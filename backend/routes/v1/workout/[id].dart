import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:magic_backend/v1/workout/workout.dart';

// reponse handler
Future<Response> onRequest(RequestContext context, String id) async {
  switch (context.request.method) {
    case HttpMethod.get:
      // /v1/workout/:id
      // GET workout by id
      return _get(context, id);
    case HttpMethod.patch:
      // /v1/workout/:id
      // PATCH update a workout
      return _patch(context, id);
    case HttpMethod.delete:
      // /v1/workout/:id
      // DELETE delete a workout
      return _delete(context, id);
    case HttpMethod.post:
      // /v1/workout/:id
      // POST create a workout
      return _post(context, id);
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.put:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context, String id) async {
  try {
    final workoutServiceImpl = context.read<WorkoutServiceImpl>();
    final workoutResponse = await workoutServiceImpl.getAllWorkoutsById(id);

    return Response.json(
      body: workoutDbModelListToMap(workoutResponse),
    );
  } catch (e) {
    return Response(statusCode: HttpStatus.internalServerError);
  }
}

Future<Response> _post(RequestContext context, String id) async {
  try {
    final workoutServiceImpl = context.read<WorkoutServiceImpl>();
    final requestJson = await context.request.json() as Map<String, dynamic>?;
    if (requestJson == null) {
      return Response(statusCode: HttpStatus.badRequest);
    }
    final workoutRequest = CreateWorkoutRequest.fromMap(requestJson);
    final workoutResponse = await workoutServiceImpl.createWorkout(
      id,
      workoutRequest,
    );
    return Response.json(
      statusCode: HttpStatus.created,
      body: workoutResponse.toMap(),
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

Future<Response> _patch(RequestContext context, String id) async {
  try {
    final workoutServiceImpl = context.read<WorkoutServiceImpl>();
    final requestJson = await context.request.json() as Map<String, dynamic>?;
    if (requestJson == null) {
      return Response(statusCode: HttpStatus.badRequest);
    }
    final workoutRequest = CreateWorkoutRequest.fromMap(requestJson);
    final workoutResponse = await workoutServiceImpl.updateWorkout(
      id,
      workoutRequest,
    );
    return Response.json(
      body: workoutResponse.toMap(),
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
    final workoutServiceImpl = context.read<WorkoutServiceImpl>();
    await workoutServiceImpl.deleteWorkout(id);
    return Response.json(body: {'message': 'workout deleted'});
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.internalServerError,
      body: {
        'message': e.toString(),
      },
    );
  }
}
