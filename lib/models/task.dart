import 'package:flutter/foundation.dart';

/// Task model
/// A task contains a string text and a status completed.
class TaskModel extends ChangeNotifier {
  final String text;
  bool completed;

  TaskModel({this.text, this.completed = false});

  TaskModel.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        completed = json['completed'];

  Map<String, dynamic> toJson() => {'text': text, 'completed': completed};

  void toggle() {
    completed = !completed;
    notifyListeners();
  }
}
