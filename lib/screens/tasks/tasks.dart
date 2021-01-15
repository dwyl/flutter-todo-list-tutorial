import 'package:provider/provider.dart';
import 'package:todolist/models/todoList.dart';
import 'package:todolist/screens/tasks/todolist.dart';
import 'package:flutter/material.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TodoList'),
        ),
        body: ChangeNotifierProvider(
          create: (context) => TodoListModel(),
          child: TodoList() ,)
    );
  }
}