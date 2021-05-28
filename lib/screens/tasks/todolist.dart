import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/todoList.dart';
import 'package:todolist/screens/tasks/task.dart';
import 'package:todolist/screens/tasks/providers.dart';

class TodoListWidget extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _tasks = watch(todolistProvider);
    List<Widget> taskWidget = 
          _tasks.tasks.map((task) {
            return TaskWidget();
          }).toList();

    return Column(children: [
      Expanded(child: 
        ListView(
          children: taskWidget
        )
      ),
      // Consumer<TodoListModel>(
      //   builder: (context, tasks, child) {
      //     return TextField(
      //       controller: _controller,
      //       decoration: InputDecoration(
      //           border: OutlineInputBorder(
      //               borderSide: BorderSide(color: Colors.teal)),
      //           labelText: 'new task'),
      //       onSubmitted: (newTask) {
      //         tasks.addTaks(TaskModel(
      //             text:
      //                 newTask)); // create new instance of task changeNotifier model
      //         _controller.clear(); // clear the text input after adding taks
      //         tasks.saveTasksToSharedPrefs();
      //       },
      //     );
      //   },
      // )
    ]);
  }
}
