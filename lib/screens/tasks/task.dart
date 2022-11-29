import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/todoList.dart';
import 'package:todolist/screens/tasks/providers.dart';

class TaskWidget extends ConsumerWidget {
  TaskWidget(TaskModel this.task, int this.taskIndex);

  TaskModel task;
  int taskIndex;

  // method to style completed/uncompleted item
  TextStyle _taskStyle(completed) {
    if (completed)
      return TextStyle(
        color: Colors.black54,
        decoration: TextDecoration.lineThrough,
      );
    else
      return TextStyle(decoration: TextDecoration.none);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _tasks = ref.watch(todolistProvider);

    return CheckboxListTile(
      title: Text(this.task.text, style: _taskStyle(this.task.completed)),
      value: this.task.completed,
      onChanged: (newValue) {
        this.task.toggle();
        _tasks.updateTask(this.task, this.taskIndex);
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
