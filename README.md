# flutter-todo-list-tutorial
A detailed example/tutorial building a Todo List App using Flutter

This Tutorial will show you process of building of a todo-list with Flutter.

Make sure to complete the flutter Installation before you get started. 
Here you have the link to Install flutter:
(https://flutter.dev/docs/get-started/install)
 
 1-Create a new Flutter Project.

![3fSwulrV0S](https://user-images.githubusercontent.com/27420533/72349907-5037f580-36d5-11ea-8bc8-3f2ec65a28be.png)

2-Delete all the "main.dart" comments that are generated after creating a new project.

3- Create a new "bottomNavigationBar" and inside that "bottomNavigationBar" create a "Row" to save the buttons to add new tasks/events and the settings button.

```ruby
   bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
```
4- Inside the row add 2 buttons.

5-Use the function "FloatingActionButtonLocation" to center the add button.

```ruby
child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

```
