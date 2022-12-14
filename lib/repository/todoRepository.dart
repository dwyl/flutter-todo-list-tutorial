import 'dart:convert';

import 'package:todo_app/todo.dart';
import 'package:http/http.dart' as http;

// Localhost ios emulator 127.0.0.1 or localhost
// Localhost android emulator 10.0.2.2 or localhost
// Localhost real device means IP address of network (phone and computer have to be on the same network)
const baseUrl = 'http://192.168.1.201:4000/api';

class TodoRepository {

  static Future<List<Todo>> fetchTodoList() async {
    final response = await http.get(Uri.parse('$baseUrl/items/'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Todo>.from(l.map((model) => Todo.fromJson(model)));
    } else {
      throw Exception('Failed to load Todo\'s.');
    }
  }
}
