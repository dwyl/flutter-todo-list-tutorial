import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/todoList.dart';
import 'package:todolist/screens/tasks/providers.dart';
import 'package:todolist/screens/tasks/task.dart';
import 'package:todolist/screens/tasks/tasks.dart';
import 'package:todolist/screens/tasks/todolist.dart';

void main() {
  testWidgets('Test Todolist widget', (WidgetTester tester) async {
    final todoList = TodoListChangeNotifier();
    final task1 = TaskModel(text: "task 1");
    final task2 = TaskModel(text: "task 2");
    final task3 = TaskModel(text: "task 3");

    todoList.addTask(task1);
    todoList.addTask(task2);
    todoList.addTask(task3);

    // Localizations, Directionality and Media Query are needed for the widget to be tested
    Widget testWidget = Localizations(
        locale: const Locale('en', 'US'),
        delegates: const <LocalizationsDelegate<dynamic>>[
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: MediaQuery(
                data: new MediaQueryData(),
                child: Material(
                    child: ProviderScope(
                        overrides: [
                      todolistProvider.overrideWith((ref) {
                        return todoList;
                      })
                    ],
                        // Our application, which will read from todoListProvider to display the todo-list.
                        // You may extract this into a MyApp widget
                        child: Scaffold(body: TodoListWidget()))))));

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    final tasks = find.byType(TaskWidget);
    expect(tasks, findsAtLeastNWidgets(3));
  });

  testWidgets('Add a new task', (WidgetTester tester) async {
    final todoList = TodoListChangeNotifier();

    // Localizations, Directionality and Media Query are needed for the widget to be tested
    Widget testWidget = Localizations(
        locale: const Locale('en', 'US'),
        delegates: const <LocalizationsDelegate<dynamic>>[
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
        child: MediaQuery(
            data: new MediaQueryData(),
            child: Material(
                child: ProviderScope(
                    overrides: [
                  todolistProvider.overrideWith((ref) {
                    return todoList;
                  })
                ],
                    // Our application, which will read from todoListProvider to display the todo-list.
                    // You may extract this into a MyApp widget
                    child: Scaffold(body: TodoListWidget())))));



    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    // enter text in field
    await tester.enterText(textField, 'task 1');
    final textFieldWidget = tester.widget(textField) as TextField;
    textFieldWidget.onSubmitted!(textFieldWidget.controller!.value.text);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    // find new task created
    expect(find.byType(CheckboxListTile), findsOneWidget);
    expect(find.text('task 1'), findsOneWidget);
  });
}
