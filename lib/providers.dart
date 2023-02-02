import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/repository/todoRepository.dart';
import 'package:todo_app/todo.dart';

// We expose our instance of TodoRepository in a provider
final repositoryProvider = Provider((ref) => TodoRepository());

/// Creates a [TodoList].
///
/// We are using [StateNotifierProvider] here as a `List<Todo>` is a complex
/// object, with advanced business logic like how to edit a todo.
final todoListProvider = StateNotifierProvider<TodoList, AsyncValue<List<Todo>>>((ref) {
  final repository = ref.read(repositoryProvider);

  return TodoList(repository);
});

/// Enum with possible filters of the `todo` list.
enum TodoListFilter {
  all,
  active,
  completed,
}

/// The currently active filter.
///
/// Notice we are using [StateProvider] here as there.
/// It's just a single value so there is no logic to be implemented.
final todoListFilter = StateProvider((_) => TodoListFilter.all);

/// The number of uncompleted todos
///
/// We are using [Provider].
/// There are a number of advantages, mainly this value being cached,
/// even if multiple widgets are reading this value - it will only be computed once.
///
/// This will also optimise unneeded rebuilds if the todo-list changes, but the
/// number of uncompleted todos doesn't (such as when editing a todo).
final uncompletedTodosCount = Provider<int>((ref) {
  final count = ref.watch(todoListProvider).value?.where((todo) => !todo.completed).length;
  return count ?? 0;
});

/// The list of todos after applying a [todoListFilter].
///
/// This too uses [Provider], to avoid recomputing.
/// It only re-calculates if either the `filter` or `todos`list updates.
final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider).valueOrNull;

  if (todos != null) {
    switch (filter) {
      case TodoListFilter.completed:
        return todos.where((todo) => todo.completed).toList();
      case TodoListFilter.active:
        return todos.where((todo) => !todo.completed).toList();
      case TodoListFilter.all:
        return todos;
    }
  } else {
    return [];
  }
});
