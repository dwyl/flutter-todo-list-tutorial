import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/screens/tasks/task.dart';

// The TodoList class is statefull
// to allow new item to be added to the list of tasks
class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Task> _tasks = [];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: ListView(
        children: _tasks.map((Task task) => TaskWidget(task: task)).toList(),
      )),
      TextField(
        controller: _controller,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
            labelText: 'new task'),
        onSubmitted: (newTask) {
          setState(() {
            _tasks.add(Task(text: newTask));
            _controller
                .clear(); // clear the text input when an item is added to the list of tasks
            saveTasksToSharedPrefs(_tasks);
          });
        },
      )
    ]);
  }

  Future<void> getTasksFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    final tasksJson = prefs.getString('tasks') ?? '[{"text": "hello", "completed": true}]';
    // https://flutter.dev/docs/cookbook/networking/background-parsing#convert-the-response-into-a-list-of-photos
    final jsonListTasks = jsonDecode(tasksJson).cast<Map<String, dynamic>>();

    final tasks = jsonListTasks.map<Task>((m) => Task.fromJson(m)).toList();
    setState(() {
      _tasks = tasks;
    });
  }

  Future<void> saveTasksToSharedPrefs(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(tasks);
    prefs.setString('tasks', json);
  }

  @override
  void initState() {
    // super.initState must be called first
    super.initState();
    getTasksFromSharedPrefs();
  }
}
