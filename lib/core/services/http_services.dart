// Important
// This file contains all the http functions.
// The baseUrl and token are calle from constants file.

import 'package:dio/dio.dart';
import 'package:to_do_app/core/constants.dart';
import 'package:to_do_app/core/models/task_model.dart';

class HTTPServices {
  // Create a instance of Dio library.
  final _dio = Dio();

  // This function is used to get task from the server.
  Future<List<TaskModel>> getTasks() async {
    try {
      var response = await _dio.get('$baseUrl/tasks',
          options: Options(headers: {"Authorization": "Bearer $token"}),
          queryParameters: {'token': token});
      // If the statusCode >= 400 it means bad response, we will return a empty array
      if (response.statusCode >= 400) {
        return [];
      } else {
        // We need to use forEach to get an item and use the function fromJson.
        List<TaskModel> tasks = [];
        response.data.forEach((value) {
          tasks.add(TaskModel.fromJson(value));
        });
        return tasks;
      }
    } catch (e) {
      // We print all the events to see in console.
      // ignore: avoid_print
      print('ERROR IN GET TASKS' + e.toString());
      return [];
    }
  }

  // This function is for create task.
  Future<Map<String, dynamic>> createTask(TaskModel task) async {
    try {
      var response = await _dio.post('$baseUrl/tasks',
          data: task.toJson(),
          options: Options(
              headers: {"Authorization": "Bearer $token"},
              contentType: Headers.formUrlEncodedContentType),
          queryParameters: {'token': token});

      if (response.statusCode >= 400) {
        return {"status": false};
      } else {
        return {"status": true};
      }
    } catch (e) {
      // We print all the events to see in console.
      // ignore: avoid_print
      print('ERROR IN CREATE TASK' + e.toString());
      return {"status": false};
    }
  }

  Future<Map<String, dynamic>> updateTask(TaskModel task) async {
    try {
      var response = await _dio.put('$baseUrl/tasks/${task.id}',
          data: task.toJson(),
          options: Options(
              headers: {"Authorization": "Bearer $token"},
              contentType: Headers.formUrlEncodedContentType),
          queryParameters: {'token': token});
      if (response.statusCode >= 400) {
        return {"status": false};
      } else {
        return {"status": true};
      }
    } catch (e) {
      // We print all the events to see in console.
      // ignore: avoid_print
      print('ERROR IN UPDATE TASK' + e.toString());
      return {"status": false};
    }
  }

  Future<Map<String, dynamic>> deleteTask(TaskModel task) async {
    try {
      var response = await _dio.delete('$baseUrl/tasks/${task.id}',
          data: task.toJson(),
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode >= 400) {
        return {"status": false};
      } else {
        return {"status": true};
      }
    } catch (e) {
      // We print all the events to see in console.
      // ignore: avoid_print
      print('ERROR IN DELETE TASK' + e.toString());
      return {"status": false};
    }
  }
}
