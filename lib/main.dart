import 'package:flutter/material.dart';
import 'package:todolist/screens/tasks/tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  return runApp(
      ProviderScope(child: MaterialApp(title: 'TodoList', home: Tasks())));
}
