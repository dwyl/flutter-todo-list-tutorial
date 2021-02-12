import 'package:flutter/material.dart';

class CompletedTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Completed'),
        ),
        body: Text('completed tasks')
        );
  }
}
