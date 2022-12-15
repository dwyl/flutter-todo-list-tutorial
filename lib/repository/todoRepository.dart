import 'dart:convert';

import 'package:todo_app/todo.dart';
import 'package:http/http.dart' show Client;

// Localhost ios emulator - 127.0.0.1
// Localhost android emulator - 10.0.2.2
// Localhost real device or ios or android - IP address of network (device and computer have to be on the same network)
// Make sure your server is running on "0.0.0.0:PORT" so it can be accessible through the IP network
const baseUrl = 'http://192.XXX.X.XXX:4000/api';

class TodoRepository {
  Client client = Client();

  Future<List<Todo>> fetchTodoList() async {
    final response = await client.get(Uri.parse('$baseUrl/items/'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Todo>.from(l.map((model) => Todo.fromJson(model)));
    } else {
      throw Exception('Failed to load Todo\'s.');
    }
  }

  Future<Todo> createTodo(String description) async {
    final response = await client.post(Uri.parse('$baseUrl/items/'), body: {"text": description, "status": "0", "person_id": "0"});

    if (response.statusCode == 200) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Todo.');
    }
  }

  Future<Todo> updateTodoText(String id, String text) async {
    final response = await client.put(Uri.parse('$baseUrl/items/$id'), body: {"text": text});

    if (response.statusCode == 200) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update Todo text.');
    }
  }

  Future<Todo> updateTodoStatus(String id, bool completed) async {
    final response = await client.put(Uri.parse('$baseUrl/items/$id/status'), body: {"status": completed == true ? "1" : "0"});

    if (response.statusCode == 200) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update Todo text.');
    }
  }
}
