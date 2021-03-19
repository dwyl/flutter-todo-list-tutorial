import 'package:todolist/models/task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Decode and encode task to json', () {
    final json = {'text': 'task #1', 'completed': true};
    final TaskModel t = TaskModel.fromJson(json);

    expect(t.completed, true);
    expect(t.text, 'task #1');
    expect(t.toJson(), json);
  });

  test('Toggle task completed/uncompleted', () {
    final item = TaskModel(text: 'new item', completed: false);
    item.toggle();
    expect(item.completed, true);
    item.toggle();
    expect(item.completed, false);
  });
}
