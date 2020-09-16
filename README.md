# Flutter TodoList Tutorial

[![Build Status](https://travis-ci.com/dwyl/flutter-todo-list-tutorial.svg?branch=master)](https://travis-ci.com/dwyl/flutter-todo-list-tutorial)

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

## Initialise application

Create application:

```sh
flutter create --org com.dwyl --project-name todolist .
```
