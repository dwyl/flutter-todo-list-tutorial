/// Task model
/// A task contains a string text and a status completed.
class Task {
  final String text;
  bool completed;

  Task({this.text, this.completed = false});

  Task.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        completed = json['completed'];

  Map<String, dynamic> toJson() => {'text': text, 'completed': completed};
}
