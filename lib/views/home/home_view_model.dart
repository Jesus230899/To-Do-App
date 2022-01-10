import 'package:to_do_app/core/base/base_view_model.dart';
import 'package:to_do_app/core/models/task_model.dart';
import 'package:to_do_app/core/services/http_services.dart';

class HomeViewModel extends BaseViewModel {
  final _httpServices = HTTPServices();

  List<TaskModel> _tasks = [
    TaskModel(
        comments: 'Este es un comentario',
        description:
            'Esta es la descripcion descripcion descripcion descripcion descripcion descripcion descripcion descripcion descripcion descripcion descripcion descripcion descripcion descripcion descripcion descripcion descripcion descripcion descripcion descripcion',
        dueDate: "2021-01-09",
        id: 1,
        isCompleted: false,
        tags: 'Personal',
        title: "Este es el titulo descripcion descripcion "),
    TaskModel(
        comments: 'Ejemplo',
        description: 'Ejemplo',
        dueDate: "2021-01-09",
        id: 2,
        isCompleted: true,
        tags: 'General',
        title: "Ejemplo"),
    TaskModel(
        comments: 'Este es un comentario',
        description: 'aaaaaa',
        dueDate: "2021-01-09",
        id: 3,
        isCompleted: false,
        tags: 'Pendiente',
        title: "aaaaaaaa"),
    TaskModel(
        comments: 'Este es un comentario',
        description: 'bbbbbbbb',
        dueDate: "2021-01-09",
        id: 4,
        isCompleted: false,
        tags: 'Pendiente',
        title: "bbbbbbbb"),
  ];
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

  Future<void> onInit() async {
    await getNotes();
  }

  Future<void> getNotes() async {
    var resp = await _httpServices.getTasks();
    // tasks = resp;
    loader = false;
  }

  void search(String value) {
    List<TaskModel> temp = [];
    if (value.isEmpty) {
      showSearch = false;
      temp.addAll(tasks);
    } else {
      for (TaskModel task in tasks) {
        if (task.title.toLowerCase().contains(value.toLowerCase()) ||
            task.description.toLowerCase().contains(value.toLowerCase())) {
          showSearch = true;
          temp.add(task);
        }
      }
    }
    resultTask = temp;
  }
}
