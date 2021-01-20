import 'package:flutter/material.dart';
import 'package:todolist/models/task.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/todoList.dart';

class TaskWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Consumer<TaskModel>(builder: (context, task, child) {
      return CheckboxListTile(
        title: Text(
          task.text,
          style: _taskStyle(task.completed),
        ),
        value: task.completed,
        onChanged: (newValue) {
          task.toggle();
          Provider.of<TodoListModel>(context, listen: false)
              .saveTasksToSharedPrefs();
        },
        controlAffinity: ListTileControlAffinity.leading,
      );
    });
  }
}
