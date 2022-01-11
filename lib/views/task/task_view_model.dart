import 'package:flutter/material.dart';
import 'package:to_do_app/core/base/base_view_model.dart';
import 'package:to_do_app/core/models/task_model.dart';
import 'package:to_do_app/core/services/http_services.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/widgets/alerts.dart';
import 'package:to_do_app/widgets/snakbar.dart';

class TaskViewModel extends BaseViewModel {
  // We create an instance of HTTPService to use his functions
  final HTTPServices _httpServices = HTTPServices();
  // We use formKey to create an option to validate the form whit a not empty title.
  GlobalKey<FormState> formKey = GlobalKey();
  // We initilize some variables needed in the screen.
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionControler = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TaskModel _taskModel;
  bool _isCompleted = false;
  String _tag = 'General';
  bool isEditable;
  bool _loader = false;

  // Getters
  TaskModel get taskModel => _taskModel;
  bool get isCompleted => _isCompleted;
  String get tag => _tag;
  bool get loader => _loader;

  // Setters
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

  // This function is called when the user go to this page
  void onInit({@required BuildContext context}) {
    // We receive the data sended from homePage
    var arg = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    // isEditable is assign value
    isEditable = arg['edit'];
    // If the task sended is different to null, we fill some data.
    if (arg['task'] != null) {
      taskModel = arg['task'];
      tag = taskModel.tags;
      isCompleted = taskModel.isCompleted == 0 ? false : true;
      titleController.text = taskModel.title;
      descriptionControler.text = taskModel.description;
    }
  }

  void onPressed(BuildContext context) async {
    // If we want validate with validator formKey atribute uncomment this line
    // if (formKey.currentState.validate()) {
    if (titleController.text.isNotEmpty) {
      // Create a temp object to TaskModel
      TaskModel taskTemp;
      // If the value sended in arg is true, we will update the task
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
        // Else, we create the task
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
      // If the validation has result false, we show an alert with info about the issue.
    } else {
      showDialogInfo(
          context: context,
          title: 'Campos vacios',
          description: 'El título es obligatorio');
    }
  }

  // This function is used to return the current date, is used to send the dueDate in the task.
  String getCurrentDate() {
    var dateFormate = DateFormat("yyyy-MM-dd")
        .format(DateTime.parse(DateTime.now().toString()));
    return dateFormate;
  }

  // This function is used to update a task.
  void _updateTask(TaskModel task, BuildContext context) {
    // We change the loader to true, when loader is true, we show a loader in the middle of the screen.
    loader = true;
    // Call a function updateTask and then we receive a response.
    _httpServices.updateTask(task).then((resp) {
      // If the status from resp is true, we show a snakBar with a sucess message.
      if (resp['status']) {
        showSnakBar(
            context: context, color: Colors.green, text: 'Tarea modificada');
        // Else, we show a bad message.
      } else {
        showSnakBar(
            context: context,
            color: Colors.red,
            text: 'Error al modificar la tarea');
      }
      // After all, we change the loader to false.
      loader = false;
    });
  }

  // This funciton create a new task
  void _createTask(TaskModel task, BuildContext context) {
    // Again, we change the loader to true.
    loader = true;
    // We call the createTask function.
    _httpServices.createTask(task).then((resp) {
      // if the status resp is true, whe show a snakbar with success message
      if (resp['status']) {
        showSnakBar(
            context: context, color: Colors.green, text: 'Tarea eliminada');
        // Else, we show a bad message.
      } else {
        showSnakBar(
            context: context,
            color: Colors.red,
            text: 'Error al eliminar la tarea');
      }
      // We change the loader to false
      loader = false;
      // And return to HomePage sended the task added.
      Navigator.pop(context, task);
    });
  }

  // When the user press the button to delete the task, we show an confirmation alert.
  void onPressedDelete(BuildContext context) {
    showDialogInfo(
      context: context,
      title: 'Espera!',
      description: 'Estás seguro de borrar esta tarea?',
      // If the user confirm, we call the delete function.
      onPressed: () => _deleteTask(context),
    );
  }

  // This function delete a task.
  void _deleteTask(BuildContext context) {
    // Again, we change a loader to true.
    loader = true;
    // Hide the alert confirmation
    Navigator.pop(context);
    // Create a temp object.
    TaskModel taskTemp = TaskModel(
        id: taskModel.id,
        comments: commentController.text.isEmpty ? '' : commentController.text,
        description: titleController.text.isEmpty ? '' : titleController.text,
        dueDate: getCurrentDate(),
        isCompleted: 0,
        tags: tag,
        title: titleController.text);
    // Call the function to delete the task sended the taskTemp.
    _httpServices.deleteTask(taskTemp).then((resp) {
      // If the status resp is true, we show a success message, else, we show a bad message.
      if (resp['status']) {
        showSnakBar(
            context: context, color: Colors.green, text: 'Tarea eliminada');
      } else {
        showSnakBar(
            context: context,
            color: Colors.red,
            text: 'Error al eliminar la tarea');
      }
      // We change the loader to false;
      loader = false;
      // We return to HomePage send the id of this Task to delete from the list.
      Navigator.pop(context, taskTemp.id);
    });
  }
}
