# Flutter TodoList Tutorial

Create a simple todolist Flutter application

## Widgets

Flutter is using Widgets to create the applications' UI.
Widgets let you declare how and what to render on the screen.

Widgets can be composed to create more complex UI, creating a widgets tree,
similar to the [Document Object Model](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction)
which is used to represent html pages.

For example a todo list app could be represented with the follownig wireframe:

![todolist-app](https://user-images.githubusercontent.com/6057298/93343915-f3bf4400-f828-11ea-9087-d7cac865cecd.png)

From there we can start to have an idea of the widgets tree structure:

![widgets-tree](https://user-images.githubusercontent.com/6057298/93343977-03d72380-f829-11ea-8c4b-dc964c591e97.png)

see also:

- Introduction to widgets: <https://flutter.dev/docs/development/ui/widgets-intro>
- Widget catalog: <https://flutter.dev/docs/development/ui/widgets>
- widget index: <https://flutter.dev/docs/reference/widgets>
- widget of the week on Youtube: <https://www.youtube.com/watch?v=b_sQ9bMltGU&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG>

## Create a new Flutter application

### A quick CLI tour

You can create a new Flutter project with the following command line:

```sh
flutter create --org com.dwyl --project-name todolist .
```

This will create the project `todolist` in the current folder `.`.
The `--org` flag uses the [reverse domain name notation](https://en.wikipedia.org/wiki/Reverse_domain_name_notation) to identify your application.

You can then run the application with `flutter run` and run the tests with `flutter test`.

For the list of command type `flutter help`.
For more details about a specific command, for example `create`, run `flutter create --help`

### Material Design

[Material Design](https://material.io/design/introduction) is a guideline to create user interface.
Flutter implements the guideline with the [material components widgets](https://flutter.dev/docs/development/ui/widgets/material).
This list of widgest allow us to create rapdly a UI folling the best practices from material design.
To use these widgets you need first to import the `material` Dart package with `import 'package:flutter/material.dart';`
You can then browse all the material widgets and select the ones required for your application <https://api.flutter.dev/flutter/material/material-library.html>

You have also the possiblity to create an IOs look by using the [Cupertino widgets package](https://flutter.dev/docs/development/ui/widgets/cupertino)

### Main Widgets used

- [Scaffold](https://api.flutter.dev/flutter/material/Scaffold-class.html)
- [AppBar](https://api.flutter.dev/flutter/material/AppBar-class.html)
- [CheckboxListTile](https://api.flutter.dev/flutter/material/CheckboxListTile-class.html)
- [ListView](https://api.flutter.dev/flutter/widgets/ListView-class.html)
- [TextField](https://api.flutter.dev/flutter/material/TextField-class.html)
- [Column](https://api.flutter.dev/flutter/widgets/Column-class.html)
- [Expanded](https://api.flutter.dev/flutter/widgets/Expanded-class.html)

Note that the `Column` and `Exapanded` widgets are "space" widgets.

Flutter provide a widget inspector where you can see the full tree
of the application:

![widget tree](https://user-images.githubusercontent.com/6057298/93480078-f6876b00-f8f4-11ea-95df-3c81321e8284.png)

### Create the application

- [runApp](https://api.flutter.dev/flutter/widgets/runApp.html)
- [MaterialApp](https://api.flutter.dev/flutter/material/MaterialApp-class.html)

Dart requires a `main` function to be defined to create the start of your program.

```dart
void main() {
    print('hello');
}
```

the `runApp` function is used in the main function and takes a widget as parameter.
This widget becomes the root element of your application and it is displayed on the
user screen.

The `MaterialApp` widget create a material design application.

```dart
void main() {
  runApp(MaterialApp(title: 'TodoList', home: App()));
```

Note that the `App` widget is created later on as a `StatelessWidget`.

see also:

- <https://medium.com/@greg.perry/decode-materialapp-b730ee4eaed1>
