import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todolist/models/todoList.dart';
import 'package:todolist/screens/tasks/tasks.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Test Todolist widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Provider<TodoListModel>(
            create: (_) => TodoListModel(), child: Scaffold(body: Tasks()))));

    // Check title exists
    final titleFinder = find.text('TodoList');
    expect(titleFinder, findsOneWidget);

    // check input field to create new task exists
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);
   
   // find completed icon
   final completedIcon = find.byType(Icon);
   expect(completedIcon, findsOneWidget);
   await tester.tap(completedIcon);
   await tester.pumpAndSettle();
   final titleCompletedScreen = find.text('Completed Items');
   expect(titleCompletedScreen, findsOneWidget);

  });
}
