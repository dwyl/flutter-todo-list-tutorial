import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/todoList.dart';
import 'package:todolist/screens/tasks/task.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Task widget', (WidgetTester tester) async {
    final task = TaskModel(text: 'task 1');
    await tester.pumpWidget(MaterialApp(
        home: MultiProvider(
            providers: [
          ChangeNotifierProvider(create: (context) => TodoListModel()),
          ChangeNotifierProvider<TaskModel>.value(
            value: task,
          )
        ],
            child: Scaffold(
                // create a dummy scaffold to be able to use the TaskWidget
                appBar: AppBar(
                  title: Text('Task Widget Test'),
                ),
                body: TaskWidget()))));
    // find the task 1 text
    final textTask = find.text('task 1');
    expect(textTask, findsOneWidget);

    // find the checkboxListTile widget
    final checkboxListTile = find.byType(CheckboxListTile);
    expect(checkboxListTile, findsOneWidget);

    // check task is not completed
    expect(task.completed, false);

    Text textWidgetBeforeTap = tester.widget(textTask) as Text;
    expect(textWidgetBeforeTap.style.decoration, TextDecoration.none);
    await tester.tap(checkboxListTile);

    // rebuilt widget after tap action
    await tester.pumpAndSettle();
    expect(task.completed, true);
    Text textWidgetAfterTap = tester.widget(textTask) as Text;
    expect(textWidgetAfterTap.style.decoration, TextDecoration.lineThrough);
  });
}
