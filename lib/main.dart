import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: 'TodoList', home: App()));
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

class Item {
  String value;
  bool completed;

  Item(this.value, [this.completed = false]);
}

class ShowItem extends StatefulWidget {
  final Item item;

  ShowItem(this.item);

  @override
  _ShowItem createState() => _ShowItem();
}

class _ShowItem extends State<ShowItem> {
  TextStyle _itemStyle(completed) {
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
        widget.item.value,
        style: _itemStyle(widget.item.completed),
      ),
      value: widget.item.completed,
      onChanged: (newValue) {
        setState(() {
          widget.item.completed = newValue;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Item> _items = [];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: ListView(
        children: _items.map((Item item) {
          return ShowItem(item);
        }).toList(),
      )),
      TextField(
        controller: _controller,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
            labelText: 'new item'),
        onSubmitted: (newItem) {
          setState(() {
            _items.add(Item(newItem));
            _controller.clear();
          });
        },
      )
    ]);
  }
}
