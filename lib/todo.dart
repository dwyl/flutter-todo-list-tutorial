import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// Todo class.
/// Each `Todo` has an `id`, `description` and `completed` boolean field.
@immutable
class Todo {
  const Todo({
    required this.description,
    required this.id,
    this.completed = false,
  });

  final String id;
  final String description;
  final bool completed;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(id: json['id'].toString(), description: json['text'], completed: json['status'] == 0 ? false : true);
  }
}

/// An object that controls a list of [Todo].
/// We are using [`StateNotifier`](https://docs-v2.riverpod.dev/docs/providers/state_notifier_provider/)
/// as it is recommended for managing state which may change in reaction to user interaction (e.g. adding todo, delete todo, mark it as completed...).
///
/// State is immutable, hence why a copy of state is created
/// on any modification method.
class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  /// Adds `todo` item to list.
  void add(String description) {
    // Since our state is immutable, we are not allowed to do `state.add(todo)`.
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }

  /// Toggles `todo` item between completed or not completed.
  void toggle(String id) {
    final newState = [...state];
    final todoToReplaceIndex = state.indexWhere((todo) => todo.id == id);

    if (todoToReplaceIndex != -1) {
      newState[todoToReplaceIndex] = Todo(
        id: newState[todoToReplaceIndex].id,
        completed: !newState[todoToReplaceIndex].completed,
        description: newState[todoToReplaceIndex].description,
      );
    }

    state = newState;
  }

  /// Edits a `todo` item.
  void edit({required String id, required String description}) {
    final newState = [...state];
    final todoToReplaceIndex = state.indexWhere((todo) => todo.id == id);

    if (todoToReplaceIndex != -1) {
      newState[todoToReplaceIndex] = Todo(
        id: newState[todoToReplaceIndex].id,
        completed: !newState[todoToReplaceIndex].completed,
        description: description,
      );
    }

    state = newState;
  }
}
