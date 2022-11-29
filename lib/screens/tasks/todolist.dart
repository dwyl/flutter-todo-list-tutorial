import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/todoList.dart';
import 'package:todolist/screens/tasks/task.dart';
import 'package:todolist/screens/tasks/providers.dart';

class TodoListWidget extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _tasks = ref.watch(todolistProvider);

    List<Widget> taskWidgets = _tasks.tasks.asMap().entries.map((entry) {
      return TaskWidget(entry.value, entry.key);
    }).toList();

    return Column(children: [
      Expanded(child: ListView(children: taskWidgets)),
      Consumer(
        builder: (context, tasks, child) {
          return TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Add task',
            ),
            onSubmitted: (newTask) {
              _tasks.addTask(TaskModel(text: newTask)); // create new instan`ce of task changeNotifier model
              _controller.clear(); // clear the text input after adding taks
              _tasks.saveTasksToSharedPrefs();
            },
          );
          /*
          return TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)), labelText: 'new task'),
            onSubmitted: (newTask) {
              _tasks.addTask(TaskModel(text: newTask)); // create new instan`ce of task changeNotifier model
              _controller.clear(); // clear the text input after adding taks
              _tasks.saveTasksToSharedPrefs();
            },
          );
          */
        },
      )
    ]);
  }
}
