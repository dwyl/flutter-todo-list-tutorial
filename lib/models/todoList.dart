import 'package:flutter/foundation.dart';
import 'package:todolist/models/task.dart';

class TodoListModel extends ChangeNotifier {
  List<Task> tasks = [];

  void addTaks(Task task) {
    tasks.add(task);
    notifyListeners();
  }
}