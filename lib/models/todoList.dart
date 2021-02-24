import 'package:flutter/foundation.dart';
import 'package:todolist/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoListModel extends ChangeNotifier {
  List<TaskModel> tasks = [];

  void addTaks(TaskModel task) {
    tasks.add(task);
    notifyListeners();
  }

  Future<void> getTasksFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks') ?? '[]';
    // https://flutter.dev/docs/cookbook/networking/background-parsing#convert-the-response-into-a-list-of-photos
    final jsonListTasks = jsonDecode(tasksJson).cast<Map<String, dynamic>>();
    tasks = jsonListTasks.map<TaskModel>((m) => TaskModel.fromJson(m)).toList();
    notifyListeners();
  }

  Future<void> saveTasksToSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(tasks);
    prefs.setString('tasks', json);
  }

  List<TaskModel> getCompletedTasks() {
    return tasks.where((t) => t.completed == true).toList();
  }
}
