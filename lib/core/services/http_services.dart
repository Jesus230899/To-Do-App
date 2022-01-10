import 'package:dio/dio.dart';
import 'package:to_do_app/core/constants.dart';
import 'package:to_do_app/core/models/task_model.dart';

class HTTPServices {
  final _dio = Dio();

  Future<List<TaskModel>> getTasks() async {
    try {
      var response = await _dio.get('$baseUrl/tasks',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode >= 400) {
        return [];
      } else {
        List<TaskModel> tasks = [];
        response.data.forEach((value) {
          tasks.add(TaskModel.fromJson(value));
        });
        return tasks;
      }
    } catch (e) {
      // ignore: avoid_print
      print('ERROR IN GET TASKS' + e.toString());
      return [];
    }
  }

  Future<Map<String, dynamic>> createTask(TaskModel task) async {
    try {
      var response = await _dio.post('$baseUrl/tasks',
          data: task.toJson(),
          options: Options(
              headers: {"Authorization": "Bearer $token"},
              contentType: Headers.formUrlEncodedContentType));
      if (response.statusCode >= 400) {
        return {"status": false};
      } else {
        return {"status": true};
      }
    } catch (e) {
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
              contentType: Headers.formUrlEncodedContentType));
      if (response.statusCode >= 400) {
        return {"status": false};
      } else {
        return {"status": true};
      }
    } catch (e) {
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
      print('ERROR IN DELETE TASK' + e.toString());
      return {"status": false};
    }
  }
}
