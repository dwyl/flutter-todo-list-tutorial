import 'package:todolist/models/todoList.dart';
import 'package:todolist/models/task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Add a task to the todolist', () {
    final todoList = TodoListModel();
    expect(todoList.tasks.length, 0);
    final task = TaskModel(text: "task 1");
    todoList.addTaks(task);
    expect(todoList.tasks.length, 1);
  });

  test('save todolist in shared preferences', () async {
    // create and save a todolist
    final todoList = TodoListModel();
    final task = TaskModel(text: "task 1");
    final task2 = TaskModel(text: "task 2");
    todoList.addTaks(task);
    todoList.addTaks(task2);
    await todoList.saveTasksToSharedPrefs();

    // get tasks from shared preferences
    final todoList2 = TodoListModel();
    await todoList2.getTasksFromSharedPrefs();
    expect(todoList2.tasks.length, 2);
  });
}
