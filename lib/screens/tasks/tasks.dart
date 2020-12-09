import 'package:todolist/screens/tasks/todolist.dart';
import 'package:flutter/material.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TodoList'),
        ),
        body: TodoList());
  }
}