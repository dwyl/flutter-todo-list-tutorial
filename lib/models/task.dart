/// Task model
/// A task contains a string text and a status completed.
class Task {
  final String text;
  bool completed;

  Task({this.text, this.completed = false});
}