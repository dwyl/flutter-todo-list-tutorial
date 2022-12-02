// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo_app/main.dart';

void main() {
  final addTodoInput = find.byKey(addTodoKey);
  final homeComponent = find.byType(Home);

  testWidgets('Build correctly setup', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: App()));

    // Find the text input, bottom navigation
    expect(find.byKey(addTodoKey), findsOneWidget);
    expect(find.byKey(bottomNavigationBarKey), findsOneWidget);

    // Verify that a todo item is found
    expect(find.text('hey there :)'), findsOneWidget);
  });

  testWidgets('Adds todo and renders newly created todo', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: App()));

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
    await tester.pumpWidget(const ProviderScope(child: App()));

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
    await tester.pumpWidget(const ProviderScope(child: App()));

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
