import 'package:flutter/material.dart';
import 'package:todolist/models/task.dart';
// Because an item can be toggle completed/uncompleted
// the showItem class is created as statefull
class TaskWidget extends StatefulWidget {
  final Task task;

  TaskWidget({this.task}); // constructor with named parameter task

  @override
  _TaskWidget createState() => _TaskWidget();
}

class _TaskWidget extends State<TaskWidget> {
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
    return CheckboxListTile(
      title: Text(
        widget.task.text, // access the task text from the TaskWidget class with widget.task property
        style: _taskStyle(widget.task.completed),
      ),
      value: widget.task.completed,
      onChanged: (newValue) {
        setState(() {
          widget.task.completed = newValue;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
