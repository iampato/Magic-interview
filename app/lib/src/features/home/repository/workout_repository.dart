import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:magic/src/core/http_client.dart';
import 'package:magic/src/features/home/model/create_workout_request.dart';
import 'package:magic/src/features/home/model/workout_model.dart';
import 'package:magic/src/features/home/model/workout_response.dart';

class WorkoutRepository {
  // global variables
  final HttpNetworkUtil _httpNetworkUtil = HttpNetworkUtil();

  Future<List<WorkoutResponse?>> getMyWorkouts({
    required String userId,
  }) async {
    String endpoint = "workout/$userId";
    try {
      Response response = await _httpNetworkUtil.getRequest(endpoint);
      if (response.statusCode == 200) {
        List<WorkoutResponse> workoutResponse = List<WorkoutResponse>.from(
          response.data.map(
            (x) => WorkoutResponse.fromJson(x),
          ),
        );
        return workoutResponse;
        // return WorkoutResponse.fromJson(response.data);
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<WorkoutModel?> createWorkout({
    required String userId,
    required CreateWorkoutRequest request,
  }) async {
    String endpoint = "workout/$userId";
    try {
      Response response = await _httpNetworkUtil.postRequest(
        endpoint,
        request.toMap(),
      );
      Logger().i(response.realUri);
      Logger().i(response.data);
      if (response.statusCode == 201) {
        return WorkoutModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<WorkoutModel?> updateWorkout({
    required String workoutId,
    required CreateWorkoutRequest request,
  }) async {
    String endpoint = "workout/$workoutId";
    try {
      Response response = await _httpNetworkUtil.patchRequest(
        endpoint,
        request.toMap(),
      );
      if (response.statusCode == 200) {
        return WorkoutModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> deleteWorkout({
    required String workoutId,
  }) async {
    String endpoint = "workout/$workoutId";
    try {
      Response response = await _httpNetworkUtil.deleteRequest(endpoint);
      if (response.statusCode == 200) {
        return response.data["message"];
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
