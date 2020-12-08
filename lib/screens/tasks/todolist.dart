import 'package:flutter/material.dart';
import '../../models/task.dart';
import './task.dart';
// The TodoList class is statefull
// to allow new item to be added to the list of tasks
class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Task> _tasks = [];
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
            _controller.clear(); // clear the text input when an item is added to the list of tasks
          });
        },
      )
    ]);
  }

  @override
  void initState() {
    // super.initState must be called first
    super.initState();
    _tasks
    ..add(Task(text: 'default task'))
    ..add(Task(text: 'anotherstuff', completed: true));
  }
}