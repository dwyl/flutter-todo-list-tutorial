# Flutter TodoList Tutorial

Create a simple todolist Flutter application
<div align="center">
  <img src="https://user-images.githubusercontent.com/6057298/109024720-f4041b00-76b5-11eb-9221-ad8660315a0b.gif" height="600">
</div>

To run the project on your machine:
- make sure you have Dart and Flutter installed: https://flutter.dev/docs/get-started/install
- clone this repository with `git clone git@github.com:dwyl/flutter-todo-list-tutorial.git`
- Before running the application check that all the tests are passing with `flutter test`

The application contains the following main folders:

- `lib/models` Contains the `task` and `todolist` models
- `lib/screens` Contains the different screens of the application. Currently only the tasks screen exists.
  In the tasks folder you can find the task, tasks and todolist widgets which define the UI of this screen.
- `lib/widgets` This folder is used to store widgets used on multiple screen, currently this folder is empty
- `test` This contains the unit, widget and integration tests.

The application is using [Provider](https://pub.dev/packages/provider) to manage the states.
Providers allow us to notify the UI of the application when a state change. For example when a
task is toggled the `notifyListener` function is called which let the application knows that a refresh of the
task's UI is required: 

```dart
  void toggle() {
    completed = !completed;
    notifyListeners();
  }
```

## Flutter concepts

### Widgets

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

### Create a new Flutter application

#### A quick CLI tour

You can create a new Flutter project with the following command line:

```sh
flutter create --org com.dwyl --project-name todolist .
```

This will create the project `todolist` in the current folder `.`.
The `--org` flag uses the [reverse domain name notation](https://en.wikipedia.org/wiki/Reverse_domain_name_notation) to identify your application.

You can then run the application with `flutter run` and run the tests with `flutter test`.

For the list of command type `flutter help`.
For more details about a specific command, for example `create`, run `flutter create --help`

#### Material Design

[Material Design](https://material.io/design/introduction) is a guideline to create user interface.
Flutter implements the guideline with the [material components widgets](https://flutter.dev/docs/development/ui/widgets/material).
This list of widgest allow us to create rapdly a UI folling the best practices from material design.
To use these widgets you need first to import the `material` Dart package with `import 'package:flutter/material.dart';`
You can then browse all the material widgets and select the ones required for your application <https://api.flutter.dev/flutter/material/material-library.html>

You have also the possiblity to create an IOs look by using the [Cupertino widgets package](https://flutter.dev/docs/development/ui/widgets/cupertino)

#### Main Widgets used

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
