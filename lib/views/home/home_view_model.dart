import 'package:to_do_app/core/base/base_view_model.dart';
import 'package:to_do_app/core/models/task_model.dart';
import 'package:to_do_app/core/services/http_services.dart';

class HomeViewModel extends BaseViewModel {
  final _httpServices = HTTPServices();

  List<TaskModel> _tasks = [];
  bool _loader = true;

  // Getters
  List<TaskModel> get tasks => _tasks;
  bool get loader => _loader;

  // Setters
  set tasks(List<TaskModel> value) {
    _tasks = value;
    notifyListeners();
  }

  set loader(bool value) {
    _loader = value;
    notifyListeners();
  }

  Future<void> onInit() async {
    await getNotes();
  }

  Future<void> getNotes() async {
    print('Entra');
    var resp = await _httpServices.getNotes();
    tasks = resp;
    loader = false;
  }
}
