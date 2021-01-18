import 'package:flutter/foundation.dart';
import 'package:todolist/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoListModel extends ChangeNotifier {
  List<Task> tasks = [];

  TodoListModel.init() {
    getTasksFromSharedPrefs();
  }

  void addTaks(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  Future<void> getTasksFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson =
        prefs.getString('tasks') ?? '[{"text": "hello", "completed": true}]';
    // https://flutter.dev/docs/cookbook/networking/background-parsing#convert-the-response-into-a-list-of-photos
    final jsonListTasks = jsonDecode(tasksJson).cast<Map<String, dynamic>>();
    tasks = jsonListTasks.map<Task>((m) => Task.fromJson(m)).toList();
    notifyListeners();
  }

  Future<void> saveTasksToSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(tasks);
    prefs.setString('tasks', json);
  }
}
