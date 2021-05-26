import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/todoList.dart';
import 'package:todolist/screens/completed_tasks/completed_tasks.dart';

void main() {
  testWidgets('Test Todolist widget', (WidgetTester tester) async {
    final todoList = TodoListModel();
    final task = TaskModel(text: "task 1");
    final task2 = TaskModel(text: "task 2");
    final task3 = TaskModel(text: "task 3", completed: true);
    todoList.addTaks(task);
    todoList.addTaks(task2);
    todoList.addTaks(task3);
    await tester.pumpWidget(
      MaterialApp(
          home: CompletedTasks(todoList: todoList )
          ),
    );

    final textTask1 = find.text('task 1');
    final textTask2 = find.text('task 2');
    final textTask3 = find.text('task 3');
    expect(textTask1, findsNothing);
    expect(textTask2, findsNothing);
    expect(textTask3, findsOneWidget);
  });
}
