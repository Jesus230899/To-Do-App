import 'package:flutter/material.dart';
import 'package:to_do_app/core/base/base_view_model.dart';
import 'package:to_do_app/core/models/task_model.dart';
import 'package:to_do_app/core/services/http_services.dart';

class TaskViewModel extends BaseViewModel {
  final HTTPServices _httpServices = HTTPServices();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionControler = TextEditingController();
  TaskModel _taskModel;

  // // Getters
  TaskModel get taskModel => _taskModel;

  // // Setters
  set taskModel(TaskModel value) {
    _taskModel = value;
    notifyListeners();
  }

  void onInit({@required BuildContext context}) {
    var arg = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    if (arg['task'] != null) {
      taskModel = arg['task'];
      titleController.text = taskModel.title;
      descriptionControler.text = taskModel.description;
    }
  }

  void saveTask(BuildContext context) {
    // If we want validate with validator atribute uncomment this line
    // if (formKey.currentState.validate()) {
    if (titleController.text.isNotEmpty &&
        descriptionControler.text.isNotEmpty) {
    } else {}
  }
}
