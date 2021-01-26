import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/todoList.dart';
import 'package:todolist/screens/tasks/todolist.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Test Todolist widget', (WidgetTester tester) async {
    final todoList = TodoListModel();
    final task = TaskModel(text: "task 1");
    final task2 = TaskModel(text: "task 2");
    final task3 = TaskModel(text: "task 3");
    todoList.addTaks(task);
    todoList.addTaks(task2);
    todoList.addTaks(task3);
    await tester.pumpWidget(
      MaterialApp(
          home: ChangeNotifierProvider<TodoListModel>.value(
              value: todoList, child: Scaffold(body: TodoListWidget()))),
    );

    final textTask1 = find.text('task 1');
    final textTask2 = find.text('task 2');
    final textTask3 = find.text('task 3');
    expect(textTask1, findsOneWidget);
    expect(textTask2, findsOneWidget);
    expect(textTask3, findsOneWidget);
  });

  testWidgets('Add a new task', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
          home: ChangeNotifierProvider<TodoListModel>(
              create: (_) => TodoListModel(),
              child: Scaffold(body: TodoListWidget()))),
    );
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    // enter text in field
    await tester.enterText(textField, 'task 1');
    final textFieldWidget = tester.widget(textField) as TextField;
    textFieldWidget.onSubmitted(textFieldWidget.controller.value.text);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    // find new task created
    expect(find.byType(CheckboxListTile), findsOneWidget);
    expect(find.text('task 1'), findsOneWidget);
  });
}
