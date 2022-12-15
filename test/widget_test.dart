// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/src/client.dart';

import 'package:todo_app/main.dart';
import 'package:todo_app/providers.dart';
import 'package:todo_app/repository/todoRepository.dart';
import 'package:todo_app/todo.dart';
import 'package:uuid/uuid.dart';

/// Mock repository 
class FakeRepository implements TodoRepository {
  @override
  Client get client => Client();

  @override
  Future<List<Todo>> fetchTodoList() async {
    return [
      const Todo(id: '0', description: 'hey there :)'),
    ];
  }

  @override
  Future<Todo> createTodo(String description) async {
    return Todo(id: const Uuid().v4(), description: description);
  }

  @override
  Future<Todo> updateTodoStatus(String id, bool completed) async {
    return Todo(id: id, description: "hey there :)", completed: completed);
  }

  @override
  Future<Todo> updateTodoText(String id, String text) async {
    return Todo(id: const Uuid().v4(), description: text);
  }
}


void main() {
  final addTodoInput = find.byKey(addTodoKey);
  final homeComponent = find.byType(Home);

  testWidgets('Build correctly setup', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => FakeRepository())
      ], 
      child: const App())
    );

    // The first frame is a loading state.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Re-render. TodoListProvider should have finished fetching the todos by now
    await tester.pump();

    // No longer loading
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Find the text input, bottom navigation
    expect(find.byKey(addTodoKey), findsOneWidget);
    expect(find.byKey(bottomNavigationBarKey), findsOneWidget);

    // Verify that a todo item is found
    expect(find.text('hey there :)'), findsOneWidget);
  });

  testWidgets('Adds todo and renders newly created todo', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => FakeRepository())
      ], 
      child: const App())
    );

    // Re-render to skip the loading animation
    await tester.pump();

    // Type text into todo input
    await tester.enterText(addTodoInput, 'new todo');
    expect(
        find.descendant(
          of: addTodoInput,
          matching: find.text('new todo'),
        ),
        findsOneWidget);

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    // Input is cleared
    expect(
      find.descendant(
        of: addTodoInput,
        matching: find.text('new todo'),
      ),
      findsNothing,
    );

    // Verify if new todo is added
    expect(find.text('new todo'), findsOneWidget);
    expect(find.text('2 items left'), findsOneWidget);
    expect(find.text('1 items left'), findsNothing);
  });

  testWidgets('Editing a todo item', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => FakeRepository())
      ], 
      child: const App())
    );

    // Re-render to skip the loading animation
    await tester.pump();
    
    // Expect to find the default todo item
    expect(find.text('hey there :)'), findsOneWidget);
    final firstItem = find.byType(TodoItem);

    await tester.tap(firstItem);
    // Wait for the textfield to appear
    await tester.pump();

    // Don't use tester.enterText to check that the textfield is auto-focused
    tester.testTextInput.enterText('new description');
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pump();

    expect(
      find.descendant(of: firstItem, matching: find.text('hey there :)')),
      findsNothing,
    );
    expect(
      find.descendant(of: firstItem, matching: find.text('new description')),
      findsOneWidget,
    );
  });

  testWidgets('Marking todo item as done and checking it in the completed tab', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => FakeRepository())
      ], 
      child: const App())
    );

    // Re-render to skip the loading animation
    await tester.pump();

    // Getting first todo item
    final firstItem = find.byType(TodoItem);
    final firstCheckbox = find.descendant(
      of: firstItem,
      matching: find.byType(Checkbox),
    );

    expect(
      tester.widget(firstCheckbox),
      isA<Checkbox>().having((s) => s.value, 'value', false),
    );
    expect(find.text('1 items left'), findsOneWidget);
    expect(find.text('0 items left'), findsNothing);

    // Tapping on checked
    await tester.tap(firstCheckbox);
    await tester.pump();

    expect(
      tester.widget(firstCheckbox),
      isA<Checkbox>().having((s) => s.value, 'value', true),
    );
    expect(find.text('0 items left'), findsOneWidget);
    expect(find.text('1 items left'), findsNothing);

    // Switching between menus
    final bottomMenu = find.byKey(bottomNavigationBarKey);
    final allButton = find.descendant(of: bottomMenu, matching: find.byTooltip('All'));
    final activeButton = find.descendant(of: bottomMenu, matching: find.byTooltip('Active'));
    final completedButton = find.descendant(of: bottomMenu, matching: find.byTooltip('Completed'));

    // Checking if it appears on the completed tab
    await tester.tap(completedButton);
    await tester.pump();

    expect(find.text('hey there :)'), findsOneWidget);

    // Checking if it appears on the active tab
    await tester.tap(activeButton);
    await tester.pump();

    expect(find.text('hey there :)'), findsNothing);

    // Checking if it appears on the active tab
    await tester.tap(allButton);
    await tester.pump();

    expect(find.text('hey there :)'), findsOneWidget);
    await tester.tap(homeComponent);
  });
}
