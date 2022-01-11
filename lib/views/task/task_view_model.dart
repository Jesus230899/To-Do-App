import 'package:flutter/material.dart';
import 'package:to_do_app/core/base/base_view_model.dart';
import 'package:to_do_app/core/models/task_model.dart';
import 'package:to_do_app/core/services/http_services.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/widgets/alerts.dart';
import 'package:to_do_app/widgets/snakbar.dart';

class TaskViewModel extends BaseViewModel {
  final HTTPServices _httpServices = HTTPServices();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionControler = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TaskModel _taskModel;
  bool _isCompleted = false;
  String _tag = 'General';
  bool isEditable;
  bool _loader = false;

  // // Getters
  TaskModel get taskModel => _taskModel;
  bool get isCompleted => _isCompleted;
  String get tag => _tag;
  bool get loader => _loader;

  // // Setters
  set taskModel(TaskModel value) {
    _taskModel = value;
    notifyListeners();
  }

  set isCompleted(bool value) {
    _isCompleted = value;
    notifyListeners();
  }

  set tag(String value) {
    _tag = value;
    notifyListeners();
  }

  set loader(bool value) {
    _loader = value;
    notifyListeners();
  }

  void onInit({@required BuildContext context}) {
    var arg = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    isEditable = arg['edit'];
    if (arg['task'] != null) {
      taskModel = arg['task'];
      tag = taskModel.tags;
      isCompleted = taskModel.isCompleted == 0 ? false : true;
      titleController.text = taskModel.title;
      descriptionControler.text = taskModel.description;
    }
  }

  void onPressed(BuildContext context) async {
    // If we want validate with validator atribute uncomment this line
    // if (formKey.currentState.validate()) {
    if (titleController.text.isNotEmpty) {
      TaskModel taskTemp;
      if (isEditable) {
        taskTemp = TaskModel(
            id: taskModel.id,
            comments:
                commentController.text.isEmpty ? '' : commentController.text,
            description:
                titleController.text.isEmpty ? '' : titleController.text,
            dueDate: getCurrentDate(),
            isCompleted: isCompleted ? 1 : 0,
            tags: tag,
            title: titleController.text);
        _updateTask(taskTemp, context);
      } else {
        taskTemp = TaskModel(
            comments:
                commentController.text.isEmpty ? '' : commentController.text,
            description:
                titleController.text.isEmpty ? '' : titleController.text,
            dueDate: getCurrentDate(),
            isCompleted: isCompleted ? 1 : 0,
            tags: tag,
            title: titleController.text);
        _createTask(taskTemp, context);
      }
    } else {
      showDialogInfo(
          context: context,
          title: 'Campos vacios',
          description: 'El título es obligatorio');
    }
  }

  String getCurrentDate() {
    var dateFormate = DateFormat("yyyy-MM-dd")
        .format(DateTime.parse(DateTime.now().toString()));
    return dateFormate;
  }

  void _updateTask(TaskModel task, BuildContext context) {
    loader = true;
    _httpServices.updateTask(task).then((resp) {
      if (resp['status']) {
        showSnakBar(
            context: context, color: Colors.green, text: 'Tarea modificada');
      } else {
        showSnakBar(
            context: context,
            color: Colors.red,
            text: 'Error al modificar la tarea');
      }
      loader = false;
      // Navigator.pop(context);
    });
  }

  void _createTask(TaskModel task, BuildContext context) {
    loader = true;
    _httpServices.createTask(task).then((resp) {
      if (resp['status']) {
        showSnakBar(
            context: context, color: Colors.green, text: 'Tarea eliminada');
      } else {
        showSnakBar(
            context: context,
            color: Colors.red,
            text: 'Error al eliminar la tarea');
      }
      loader = false;
      Navigator.pop(context, task);
    });
  }

  void onPressedDelete(BuildContext context) {
    showDialogInfo(
      context: context,
      title: 'Espera!',
      description: 'Estás seguro de borrar esta tarea?',
      onPressed: () => _deleteTask(context),
    );
  }

  void _deleteTask(BuildContext context) {
    loader = true;
    Navigator.pop(context);
    TaskModel taskTemp = TaskModel(
        id: taskModel.id,
        comments: commentController.text.isEmpty ? '' : commentController.text,
        description: titleController.text.isEmpty ? '' : titleController.text,
        dueDate: getCurrentDate(),
        isCompleted: 0,
        tags: tag,
        title: titleController.text);
    _httpServices.deleteTask(taskTemp).then((resp) {
      if (resp['status']) {
        showSnakBar(
            context: context, color: Colors.green, text: 'Tarea eliminada');
      } else {
        showSnakBar(
            context: context,
            color: Colors.red,
            text: 'Error al eliminar la tarea');
      }
      loader = false;
      Navigator.pop(context, taskTemp.id);
    });
  }
}
