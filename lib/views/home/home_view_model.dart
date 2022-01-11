import 'package:to_do_app/core/base/base_view_model.dart';
import 'package:to_do_app/core/models/task_model.dart';
import 'package:to_do_app/core/services/http_services.dart';

class HomeViewModel extends BaseViewModel {
  // We create a instance of HTTPServices to use the funtions.
  final _httpServices = HTTPServices();

  // Initialize the necesary variables with some values.
  List<TaskModel> _tasks = [];
  bool _loader = true;

  String _tag = '';
  String _status = '';
  List<TaskModel> _resultTask = [];
  bool _showSearch = false;

  // Getters
  List<TaskModel> get tasks => _tasks;
  List<TaskModel> get resultTask => _resultTask;
  bool get loader => _loader;
  String get tag => _tag;
  String get status => _status;
  bool get showSearch => _showSearch;

  // Setters
  set tasks(List<TaskModel> value) {
    _tasks = value;
    notifyListeners();
  }

  set resultTask(List<TaskModel> value) {
    _resultTask = value;
    notifyListeners();
  }

  set loader(bool value) {
    _loader = value;
    notifyListeners();
  }

  set tag(String value) {
    _tag = value;
    notifyListeners();
  }

  set status(String value) {
    _status = value;
    notifyListeners();
  }

  set showSearch(bool value) {
    _showSearch = value;
    notifyListeners();
  }

  // This functions is called when the user go to this page.
  Future<void> onInit() async {
    await getNotes();
  }

  // This async function is used to call http services to get the task from the server
  // While this function is called, we show a loader in the screen with the variable loader.
  Future<void> getNotes() async {
    // We assign the result of the service
    var resp = await _httpServices.getTasks();
    tasks = resp;
    // loader changed to false.
    loader = false;
  }

  // This function search items in the list of task, filter with param value when is equal to title
  void search(String value) {
    // Initialize temporally array
    List<TaskModel> temp = [];
    // If the value is empty, we change showSearch to false
    if (value.isEmpty) {
      // We use showSearch to show the list tasks or show the list of search.
      showSearch = false;
    } else {
      // if value isn't empty, we use for traverse the list.
      for (TaskModel task in tasks) {
        // if the title of task contains some letter from value, we change showSearch to true for show the results and add the item to temp list.
        if (task.title.toLowerCase().contains(value.toLowerCase())) {
          showSearch = true;
          temp.add(task);
        }
      }
    }
    // Finally, we assign the temp list to resultTask list.
    resultTask = temp;
  }

  // The function updateTask is used when the user delete a task and return to home, in the list tasks and resultTaks is removed the item by the id sended.
  void updateTasks(int value) {
    tasks.removeWhere((item) => item.id == value);
    resultTask.removeWhere((item) => item.id == value);
    notifyListeners();
  }

  // The function addTask is used then the user add a task and return to home, we receive all object task in param and add at the 2 list used.
  void addTask(TaskModel task) {
    tasks.add(task);
    resultTask.add(task);
    notifyListeners();
  }
}
