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
}
