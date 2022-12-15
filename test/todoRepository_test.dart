import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/repository/todoRepository.dart';
import 'package:todo_app/todo.dart';

import 'todoRepository_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetch todos', () {
    test('returns a list of todo items if call is successful', () async {
      final client = MockClient();
      final repo = TodoRepository();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('$baseUrl/items/')))
          .thenAnswer((_) async => http.Response('[{ "id": 30, "person_id": 0, "status": 1, "text": "Another todo" }]', 200));

      repo.client = client;

      expect(await repo.fetchTodoList().then((value) => value.length), equals(1));
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      final repo = TodoRepository();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('$baseUrl/items/'))).thenAnswer((_) async => http.Response('Not Found', 404));

      repo.client = client;

      expect(repo.fetchTodoList(), throwsException);
    });
  });

  group('create todos', () {
    test('successfully creates a todo and returns the created todo', () async {
      final client = MockClient();
      final repo = TodoRepository();

      String descriptionToCreate = 'new todo';

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(Uri.parse('$baseUrl/items/'), body: {"text": "$descriptionToCreate", "status": "0", "person_id": "0"}))
          .thenAnswer((_) async => http.Response('{ "id": "1", "person_id": 0, "status": 1, "text": "$descriptionToCreate"  }', 200));

      repo.client = client;

      expect(await repo.createTodo(descriptionToCreate).then((value) => value.description), equals(descriptionToCreate));
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      final repo = TodoRepository();

      String descriptionToCreate = 'new todo';

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.post(Uri.parse('$baseUrl/items/'), body: {"text": descriptionToCreate, "status": "0", "person_id": "0"}))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      repo.client = client;

      expect(repo.createTodo(descriptionToCreate), throwsException);
    });
  });

  group('update todo text', () {
    test('successfully updates a todo and returns the updated todo', () async {
      final client = MockClient();
      final repo = TodoRepository();

      Todo updatedTodo = const Todo(description: "updated text", id: "1");

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.put(Uri.parse('$baseUrl/items/${updatedTodo.id}'), body: {"text": "${updatedTodo.description}" }))
          .thenAnswer((_) async => http.Response('{ "id": "${updatedTodo.id}", "person_id": 0, "status": 1, "text": "${updatedTodo.description}"  }', 200));

      repo.client = client;

      expect(await repo.updateTodoText(updatedTodo.id, updatedTodo.description).then((value) => value.description), equals(updatedTodo.description));
      expect(await repo.updateTodoText(updatedTodo.id, updatedTodo.description).then((value) => value.id), equals(updatedTodo.id));
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      final repo = TodoRepository();

      Todo updatedTodo = const Todo(description: "updated text", id: "1");

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.put(Uri.parse('$baseUrl/items/${updatedTodo.id}'), body: {"text": "${updatedTodo.description}" }))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      repo.client = client;

      expect(repo.updateTodoText(updatedTodo.id, updatedTodo.description), throwsException);
    });
  });

  group('update todo status', () {
    test('successfully updates a todo status and returns the updated todo', () async {
      final client = MockClient();
      final repo = TodoRepository();

      Todo updatedTodo = const Todo(description: "updated text", id: "1", completed: false);

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.put(Uri.parse('$baseUrl/items/${updatedTodo.id}/status'), body: {"status": updatedTodo.completed == true ? "1" : "0"}))
          .thenAnswer((_) async => http.Response('{ "id": "${updatedTodo.id}", "person_id": 0, "status": ${updatedTodo.completed == true ? "1" : "0"}, "text": "${updatedTodo.description}"  }', 200));

      repo.client = client;

      expect(await repo.updateTodoStatus(updatedTodo.id, updatedTodo.completed).then((value) => value.completed), equals(updatedTodo.completed));
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      final repo = TodoRepository();

      Todo updatedTodo = const Todo(description: "updated text", id: "1", completed: false);

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.put(Uri.parse('$baseUrl/items/${updatedTodo.id}/status'), body: {"status": updatedTodo.completed == true ? "1" : "0"}))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      repo.client = client;

      expect(repo.updateTodoStatus(updatedTodo.id, updatedTodo.completed), throwsException);
    });
  });
}
