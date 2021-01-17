import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/todoList.dart';
import 'package:todolist/screens/tasks/task.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(child: Consumer<TodoListModel>(builder: (context, tasks, child) {
        return ListView(
          children: tasks.tasks.map((Task task) {
            return ChangeNotifierProvider.value(
                value: task, child: TaskWidget()
            );
          }).toList(),
        );
      })),
      Consumer<TodoListModel>(
        builder: (contexst, tasks, child) {
          return TextField(
            controller: _controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
                labelText: 'new task'),
            onSubmitted: (newTask) {
              tasks.addTaks(Task(text: newTask)); // create new instance of
              _controller.clear(); // clear the text input after adding taks
              saveTasksToSharedPrefs(tasks.tasks);
            },
          );
        },
      )
    ]);
  }
}

Future<void> getTasksFromSharedPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  final tasksJson =
      prefs.getString('tasks') ?? '[{"text": "hello", "completed": true}]';
  // https://flutter.dev/docs/cookbook/networking/background-parsing#convert-the-response-into-a-list-of-photos
  final jsonListTasks = jsonDecode(tasksJson).cast<Map<String, dynamic>>();

  final tasks = jsonListTasks.map<Task>((m) => Task.fromJson(m)).toList();
  //setState(() {
  //  _tasks = tasks;
  //});
}

Future<void> saveTasksToSharedPrefs(List<Task> tasks) async {
  final prefs = await SharedPreferences.getInstance();
  final json = jsonEncode(tasks);
  prefs.setString('tasks', json);
}

  //void initState() {
    //// super.initState must be called first
    //super.initState();
    //getTasksFromSharedPrefs();
  //}
//}
