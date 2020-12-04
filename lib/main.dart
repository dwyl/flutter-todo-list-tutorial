import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(title: 'TodoList', home: App())
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TodoList'),
        ),
        body: TodoList());
  }
}

class Task {
  final String text;
  bool completed;

  Task({this.text, this.completed = false});
}

// Because an item can be toggle completed/uncompleted
// the showItem class is created as statefull
class TaskWidget extends StatefulWidget {
  final Task task;

  TaskWidget({this.task}); // constructor with named parameter item

  @override
  _TaskWidget createState() => _TaskWidget();
}

class _TaskWidget extends State<TaskWidget> {
  // method to style completed/uncompleted item
  TextStyle _taskStyle(completed) {
    if (completed)
      return TextStyle(
        color: Colors.black54,
        decoration: TextDecoration.lineThrough,
      );
    else
      return TextStyle(decoration: TextDecoration.none);
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.task.text, // access the task text from the TaskWidget class with widget.task property
        style: _taskStyle(widget.task.completed),
      ),
      value: widget.task.completed,
      onChanged: (newValue) {
        setState(() {
          widget.task.completed = newValue;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

// The TodoList class is statefull
// to allow new item to be added to the list of tasks
class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Task> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: ListView(
            children: _tasks.map((Task task) => TaskWidget(task: task)).toList(),
      )),
      TextField(
        controller: _controller,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
            labelText: 'new task'),
        onSubmitted: (newTask) {
          setState(() {
          _tasks.add(Task(text: newTask));
            _controller.clear(); // clear the text input when an item is added to the list of tasks
          });
        },
      )
    ]);
  }
}
