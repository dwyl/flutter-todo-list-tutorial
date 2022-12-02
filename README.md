# Flutter Todo App Tutorial

Quickly learn how to setup
a Todo list management app
using `Flutter` and `Riverpod`
for app state management.

# What? 💡

This is a simple **Todo list application**
that allows you to track todo items that you
create and edit. 
You can check your current active todo items,
check the completed ones and
also have an overview of every task you've created.
Oh! And it's also fully tested! 😃

This app connects to an API 
implemented with [`Phoenix`](https://github.com/dwyl/learn-phoenix-framework)
to persist the todo list items.

# Why? 🤷

As we are focused on building our [`mvp`](https://github.com/dwyl/mvp),
we are looking to have the frontend counterpart
that is **cross-platform** and fastly *iterable*.
Setting this walkthrough will help *you*
understand better the fundamentals of having
an app with a robust state management library 
that can be used in **real-world applications**.

It also helps *us* to have a detailed guide
of a fully tested app that is documented 
and is something we can go back to. 😊

# How? 💻

## 0. Prerequisites and preview

It's advisable to have a basic understanding
of the `Dart`-lang and of `Flutter`. 
If this is your first tutorial with Flutter,
we *highly* advise you to check our
learning repositories to get started!

https://github.com/dwyl/learn-dart

https://github.com/dwyl/learn-flutter

If you want a walkthrough on 
*two* simpler applications,
we highly recommend going through
these in order so you can understand
the ins and outs better.

1. https://github.com/dwyl/flutter-counter-example
2. https://github.com/dwyl/flutter-stopwatch-tutorial/pulls

This tutorial will sacrifice some
setup steps that are found in the aforementioned,
so make sure to check these out if
you feel like you are lost or 
this is your first time using Flutter.


Right! 
Before building this app,
let's check out the final result!
After cloning this repository 
and traveling to the directory you cloned the repo in,
run the following command to install the dependencies.

```sh
flutter pub get
```

To run the app, plug your phone 
or start the emulator and run the following.

```sh
flutter devices
```

If you find the wanted device, run:

```sh
flutter run
```

And you should get your app running!

If you want a more in-depth guide 
of how to get a Flutter app running
on a real device or emulator,
check our [`learn-flutter`](https://github.com/dwyl/learn-flutter)
tutorial. 
We will get you sorted in no time!

If you open the app, 
you should be able to see the following.

![preview](https://user-images.githubusercontent.com/17494745/205381031-2f11e74a-34d2-45de-bc32-bbb9d4bf9401.gif)


All the tests should also pass.
If you want to check this,
you can run `flutter test`.

This app uses [`Riverpod`](https://riverpod.dev/)
for state management inside the widget tree.
This library will allow us to declare 
and use shared state from anywhere 
and have a greater control on 
UI rebuilds.


Here is how our widget tree
will look like. 

![widgets-tree](https://user-images.githubusercontent.com/6057298/93343977-03d72380-f829-11ea-8c4b-dc964c591e97.png)

## 1. Project setup

> In this walkthrough we are going to use Visual Studio Code. 
> We will assume you have this IDE installed, 
> as well as the Flutter and Dart extensions installed. 

After restarting Visual Studio Code, 
let's create a new project! 
Click on `View > Command Palette`, 
type `Flutter` and click on `Flutter: New Project`.
It will ask you for a name of the new project.
We are going to name it **"todo_app**".

After generating the project, 
let's now add all the needed
dependencies.
As it was stated before,
we are going to be using
`Riverpod` for state management and
accessing shared data across the widget tree.
Along side this library, 
are going to also use 
[`uuid`](https://pub.dev/packages/uuid)
to generate `id`s for newly created todo items.
Additionally, we are going to use
`flutter_hooks` to make widget life-cycle management easier.

Head over to `pubspec.yaml` file 
and add the following dependencies.

```yaml
environment:
  sdk: ">=2.17.0 <3.0.0"
  flutter: ">=3.0.0"

dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.2
  flutter_riverpod: ^2.0.2
  riverpod_annotation: ^1.0.4
  hooks_riverpod: ^2.1.1
  flutter_hooks: ^0.18.5+1
  uuid: ^3.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^2.0.0
  build_runner: ^2.3.2
  riverpod_generator: ^1.0.4
```

After adding these, 
run `flutter pub get` to 
fetch the dependencies.

We now have everything we need
to start developing!

# 2. Creating `Todo` class and `TodoList`

Since we are dealing with
`Todo` items in this app,
let's start by doing that.
Let's create a file in
`lib/todo.dart` 
and add the following piece of code.

```dart
import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

@immutable
class Todo {
  const Todo({
    required this.description,
    required this.id,
    this.completed = false,
  });

  final String id;
  final String description;
  final bool completed;
}
```

We just created our `Todo` model class.
Each `todo` item has an `id`, a `description`
and a boolean `completed` field
that toggles between the `todo` item being
done or not.
Pretty simple, right? 😉

You might have noticed there is an
`@immutable` annotation being used 
for this class.
This is directly related to **code-generation**.
You might have noticed the `build_runner` 
dependency we added earlier. 
This is the tool that will generate code for us.
In short, code generation allows us to
work with `Riverpod` with a friendlier syntax
and reduce boilerplate code.
If you want to learn more about 
code generation in `Riverpod` 
and how it is useful, 
check the follow link ->
https://docs-v2.riverpod.dev/docs/about_code_generation

Let's move on.
We are going to be storing our `todo` items
in a **list** - `TodoList`.
We want this list to be *accessible*
anywhere within the widget tree.
But before that, 
let's clear some concepts.

### 2.1 - `Riverpod` Provider
When using `Riverpod`,
you are going to see the word **"Provider"** 
tossed around a lot. And for good reason,
because it's important!
**A provider is an object that encapsulates
 a piece of state and allows listening to that state.**.

 By wrapping a piece of state in a `provider`,
 you will make it so that:
 - it is acessible from multiple locations within
 the widget tree.
 - enable performance optimizations, 
 like caching the value.
 - increase testability of your application.
 - among others...

 We have acess to 
 [different types of providers](https://docs-v2.riverpod.dev/docs/concepts/providers#different-types-of-providers)
 that are suitable for different use cases.
 In our application,
 we are going to be using `Provider`,
 `StateProvider` and `StateNotifierProvider`.
 We are going to get to these when we implement them.
 😉
 > If you want to learn more
 > about Providers, 
 > check the official docs -> 
 > https://docs-v2.riverpod.dev/docs/concepts/providers/

## 2.2 - Adding `TodoList` using the `StateNotifierProvider`

Now that we know a bit about
what a `Provider` is,
let's start using one. 
Don't worry if you are still confused,
you will see how it works!
Let's create our `TodoList`.
In the `lib/todo.dart` file,
add the following code.

```dart
const _uuid = Uuid();

class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  /// Adds `todo` item to list.
  void add(String description) {
    // Since our state is immutable, we are not allowed to do `state.add(todo)`.
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }

  /// Toggles `todo` item between completed or not completed.
  void toggle(String id) {
    final newState = [...state];
    final todoToReplaceIndex = state.indexWhere((todo) => todo.id == id);

    if (todoToReplaceIndex != -1) {
      newState[todoToReplaceIndex] = Todo(
        id: newState[todoToReplaceIndex].id,
        completed: !newState[todoToReplaceIndex].completed,
        description: newState[todoToReplaceIndex].description,
      );
    }

    state = newState;
  }

  /// Edits a `todo` item.
  void edit({required String id, required String description}) {
    final newState = [...state];
    final todoToReplaceIndex = state.indexWhere((todo) => todo.id == id);

    if (todoToReplaceIndex != -1) {
      newState[todoToReplaceIndex] = Todo(
        id: newState[todoToReplaceIndex].id,
        completed: !newState[todoToReplaceIndex].completed,
        description: description,
      );
    }

    state = newState;
  }
}
```

It's breakdown time! 🎉
The first thing we notice is that
`TodoList` is *extending*
`StateNotifier<List<Todo>>`. 
**We are using a 
[`StateNotifierProvider`](https://docs-v2.riverpod.dev/docs/providers/state_notifier_provider)**!

> `StateNotifierProvider` is a provider 
> that is used to listen to and expose a `StateNotifier`.
> `StateNotifierProvider` along with `StateNotifier` 
> is Riverpod's recommended solution 
> for managing *immutable* state 
> which may change in reaction to a user interaction.
> 
>  https://docs-v2.riverpod.dev/docs/providers/state_notifier_provider

Let's dissect this.
We are using `StateNotifierProvider`
because it fits our use case.
Our list of `todos` are going to 
change according to what the user does:
we will add a `todo` item if he creates one
and update a `todo` item if he decides
to edit one.
If he marks a `todo` item as completed,
we need to update that in our `todolist`.

In the code above, we are using `StateNotifier`,
which is what `StateNotifierProvider` will expose
to the widgets. 
Think of `StateNotifier` as *an object* that is
going to change over time.

Inside the `TodoList` class,
we define **three methods**:
one that `add`s a todo to the list;
one that `toggle`s a todo item inside the list;
and one that `edits` a todo item inside the list
(e.g. update the description).
**Notice that we are not changing the object
in these functions**. 
We are creating **copies** of the state,
changing the copy and assigning it to the state.

That makes sense, right?

So, in the `add` function, 
we add a `todo` item to the list
and use the `uuid` package 
to create an `id` to the newly created item.

In the `toggle` function, 
we find the `todo` item we want
to mark as completed/uncompleted
and update it.

In the `edit` function 
we do something similar,
except we change the description
of the todo item.

Again, in all of these methods
we don't *change* the list. 
We create a new updated one
(because the state is **immutable**).

