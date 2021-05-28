import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/screens/completed_tasks/completed_tasks.dart';
import 'package:todolist/screens/tasks/todolist.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/tasks/providers.dart';

class Tasks extends ConsumerWidget {
  // display completed tasks screen
  void _goToCompletedTasks(context, todoList) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CompletedTasks(todoList: todoList)));
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final todolist = watch(todolistProvider);
    // read the provider and call getTasksFromSharedPrefs()
    todolist.getTasksFromSharedPrefs();

    return Scaffold(
        appBar: AppBar(
          title: Text('TodoList'),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {},
                ))
            //onPressed: () => _goToCompletedTasks(context, todoList)))
          ],
        ),
        body: TodoListWidget());
  }
}
