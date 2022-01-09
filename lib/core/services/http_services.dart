import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:to_do_app/core/constants.dart';
import 'package:to_do_app/core/models/task_model.dart';

class HTTPServices {
  final _dio = Dio();

  Future<List<TaskModel>> getNotes() async {
    try {
      var response = await _dio.get('$baseUrl/tasks',
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        List<TaskModel> tasks = [];
        response.data.forEach((value) {
          tasks.add(TaskModel.fromJson(value));
        });
        return tasks;
      } else {
        return [];
      }
    } catch (e) {
      // ignore: avoid_print
      print('ERROR IN GET NOTES' + e.toString());
      return [];
    }
  }

  Future<Map<String, dynamic>> createTask(TaskModel task) async {
    print(task.toJson());
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
}
