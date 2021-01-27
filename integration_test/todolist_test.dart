import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todolist/screens/tasks/tasks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("failing test example", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(title: 'TodoList', home: Tasks()));
    expect(2 + 2, equals(4));

    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    // enter text in field
    await tester.enterText(textField, 'task 1');
    final textFieldWidget = tester.widget(textField) as TextField;
    textFieldWidget.onSubmitted(textFieldWidget.controller.value.text);
    await tester.pumpAndSettle();

    // find new task created
    expect(find.byType(CheckboxListTile), findsOneWidget);
    expect(find.text('task 1'), findsOneWidget);
  });
}