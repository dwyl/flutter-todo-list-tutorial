import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/screens/tasks/task.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Task widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider<TaskModel>(
            create: (_) => TaskModel(text: 'task 1'),
            child: Scaffold(
                // create a dummy scaffold to be able to use the TaskWidget
                appBar: AppBar(
                  title: Text('Task Widget Test'),
                ),
                body: TaskWidget()))));
    
    final textTask = find.text('task 1');
    expect(textTask, findsOneWidget);
  });
}
