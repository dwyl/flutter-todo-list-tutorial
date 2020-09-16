# Flutter TodoList Tutorial

Create a simple todolist Flutter application

## Structure of a Flutter application

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

### Material Design

[Material Design](https://material.io/design/introduction) is a guideline to create user interface.
Flutter implements the guideline with the [material components widgets](https://flutter.dev/docs/development/ui/widgets/material).
This list of widgest allow us to create rapdly a UI folling the best practices from material design.
To use these widgets you need first to import the `material` Dart package with `import 'package:flutter/material.dart';`
You can then browse all the material widgets and select the ones required for your application <https://api.flutter.dev/flutter/material/material-library.html>

You have also the possiblity of creating an IOs look by using the [Cupertino widgets](https://flutter.dev/docs/development/ui/widgets/cupertino)

## Initialise application

### A quick CLI tour

Create application:

```sh
flutter create --org com.dwyl --project-name todolist .
```

```sh
flutter run
```

```sh
flutter test
```

### Main Widgets used

- [Scaffold](https://api.flutter.dev/flutter/material/Scaffold-class.html)
- [AppBar](https://api.flutter.dev/flutter/material/AppBar-class.html)
- [CheckboxListTile](https://api.flutter.dev/flutter/material/CheckboxListTile-class.html)
- [ListView](https://api.flutter.dev/flutter/widgets/ListView-class.html)
- [TextField](https://api.flutter.dev/flutter/material/TextField-class.html)

### Create the application

- [runApp](https://api.flutter.dev/flutter/widgets/runApp.html)
- [MaterialApp](https://api.flutter.dev/flutter/material/MaterialApp-class.html)

see also:

- <https://medium.com/@greg.perry/decode-materialapp-b730ee4eaed1>

### Stateless and Statefull widget

### Tests