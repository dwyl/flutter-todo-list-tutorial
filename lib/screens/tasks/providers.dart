// create a todolist provider which update when TodoListChangeNotifier calls notifyListeners()
// when adding new task to the list
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/models/todoList.dart';

final todolistProvider = ChangeNotifierProvider<TodoListChangeNotifier>((ref) {
  return TodoListChangeNotifier();
});
