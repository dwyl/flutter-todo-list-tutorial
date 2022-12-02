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
We will focus more on **shared state**
and **data management** instead of 
styling. So `Riverpod` and fetching
data from API will get the spotlight here.
🔦


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

### 2.1. `Riverpod` Provider

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

## 2.2.Adding `TodoList` using the `StateNotifierProvider`

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

## 3. Adding providers

Now that we added
the blocks to create our `provider`s,
let's do that!

In a new file `lib/providers.dart`,
add the following code.

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/todo.dart';

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList(const [
    Todo(id: '0', description: 'hey there :)'),
  ]);
});
```

We have stated before that 
we were going to be using `StateNotifierProvider`
to hold the `TodoList` so it could be shared
everywhere in the application.
But `StateNotifierProvider` exposes
`StateNotifier` object, 
which we already created (it is our `TodoList`).
Now here we are just creating it
and exposing it ☺️. 
In this case, 
we are creating a `TodoList`
with a single `todo` item by default.

### 3.1 - Filtering the `TodoList`

We want to be able to check
**all** the `todo` items,
the **active** ones (created but not completed)
and the **completed** ones.

For that, the application 
is going to need to be able
to *filter* the `TodoList` 
and know what the *current filter*
is currently being on
(if the screen is showing `all`,
or `completed` or `active` items).
Let's do this.
Add the following code to the same
`lib/providers.dart` file.

```dart
/// Enum with possible filters of the `todo` list.
enum TodoListFilter {
  all,
  active,
  completed,
}

/// The currently active filter.
final todoListFilter = StateProvider((_) => TodoListFilter.all);

/// The list of todos after applying a [todoListFilter].
final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoListFilter.all:
      return todos;
  }
});
```

We are firstly defining an `enum` with
all the possible filters. 
We added three: `all`, `active` and `completed`.

The `todoListFilter` refers to the
*currently active filter* that
is shown on screen.
For this we are using the 
[`State Provider`](https://docs-v2.riverpod.dev/docs/providers/state_provider)
provider type.
This provider type is actually a much
*simpler* `StateNotifierProvider`. 
We don't need to create a `StateNotifier` object
like we did before, 
so it's meant for very simple use-cases.
Just like this one!
We just want to know the value of the
current filter, and that is it!


The `filteredTodos` will
return the `TodoList` filtered according
to a specific filter.
If the `all` filter is applied, 
we just show all the `todo` items.
If the `completed` filter is applied,
we return the `TodoList` with only
the *completed* todo items.
It uses the 
[`Provider`](https://docs-v2.riverpod.dev/docs/providers/provider)
type provider - which is the most basic
of all of them.
It just creates a value -
in this case, an array of `todo` items.
It's useful this value (the `todo` items 
that is returned by this provider) 
only rebuilds whenever we want it to update.
So, in this case, it only updates when
`todoListFilter` (the current filter)
and `todoListProvider` (the list of `todo` items)
change.
Hence why these lines exist.

```dart
final filter = ref.watch(todoListFilter);
final todos = ref.watch(todoListProvider);
```

### 3.2. Showing how many `todo` items are left

We also want the user to know
how many `todo` items are still
left to be completed.

For this, add the following code.

```dart
final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
});
```

Similarly to what we did before,
we are using the `Provider`
type of provider.
`uncompletedTodosCount` is
only recomputated when
`todoListProvider` changes.

## 4. Creating the app

Now that all the providers
we need are set up,
we just now need to create our app,
style it to our liking 
and access this shared state we just created
accordingly!

We will now add all the code
needed for this to work and 
we'll walk you through it 
and explain it in sections.

For now, let's add our code.
In the `lib/main.dart` file,
add the following.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'providers.dart';
import 'todo.dart';

/// Keys for components for testing
final bottomNavigationBarKey = UniqueKey();
final addTodoKey = UniqueKey();

// coverage:ignore-start
void main() {
  runApp(const ProviderScope(child: App()));
}
// coverage:ignore-end

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends HookConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodos);
    final newTodoController = useTextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            TextField(
              key: addTodoKey,
              controller: newTodoController,
              decoration: const InputDecoration(
                labelText: 'What do we need to do?',
              ),
              onSubmitted: (value) {
                ref.read(todoListProvider.notifier).add(value);
                newTodoController.clear();
              },
            ),

            const SizedBox(height: 42),
            
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                '${ref.watch(uncompletedTodosCount)} items left',
                style: const TextStyle(fontSize: 20),),
            ),

            if (todos.isNotEmpty) const Divider(height: 0),
            for (var i = 0; i < todos.length; i++) ...[

              if (i > 0) const Divider(height: 0),
              ProviderScope(
                  overrides: [
                    _currentTodo.overrideWithValue(todos[i]),
                  ],
                  child: const TodoItem(),
              ),

            ],
          ],
        ),
        bottomNavigationBar: const Menu(),
      ),
    );
  }
}

/// Bottom menu widget
class Menu extends HookConsumerWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(todoListFilter);

    int currentIndex() {
      switch (filter) {
        case TodoListFilter.completed:
          return 2;
        case TodoListFilter.active:
          return 1;
        case TodoListFilter.all:
          return 0;
      }
    }

    return BottomNavigationBar(
      key: bottomNavigationBarKey,
      elevation: 0.0,
      onTap: (value) {
        if (value == 0) ref.read(todoListFilter.notifier).state = TodoListFilter.all;
        if (value == 1) ref.read(todoListFilter.notifier).state = TodoListFilter.active;
        if (value == 2) ref.read(todoListFilter.notifier).state = TodoListFilter.completed;
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'All',
          tooltip: 'All'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.circle),
          label: 'Active',
          tooltip: 'Active',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.done),
          label: 'Completed',
          tooltip: 'Completed',
        ),
      ],
      currentIndex: currentIndex(),
      selectedItemColor: Colors.amber[800],
    );
  }
}


/// A provider which exposes the [Todo] displayed by a [TodoItem].
///
/// By retrieving the [Todo] through a provider instead of through its
/// constructor, this allows [TodoItem] to be instantiated using the `const` keyword.
///
/// This encapuslation ensures that when adding/removing/editing todos, 
/// only what the impacted widgets rebuilds, instead of the entire list of items.
final _currentTodo = Provider<Todo>((ref) => throw UnimplementedError());

class TodoItem extends HookConsumerWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(_currentTodo);
    final itemFocusNode = useFocusNode();
    final itemIsFocused = useIsFocused(itemFocusNode);

    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Material(
      color: Colors.white,
      elevation: 6,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = todo.description;
          } else {
            // Commit changes only when the textfield is unfocused, for performance
            ref.read(todoListProvider.notifier).edit(id: todo.id, description: textEditingController.text);
          }
        },
        child: ListTile(
          onTap: () {
            itemFocusNode.requestFocus();
            textFieldFocusNode.requestFocus();
          },
          leading: Checkbox(
            value: todo.completed,
            onChanged: (value) => ref.read(todoListProvider.notifier).toggle(todo.id),
          ),
          title: itemIsFocused
              ? TextField(
                  autofocus: true,
                  focusNode: textFieldFocusNode,
                  controller: textEditingController,
                )
              : Text(todo.description),
        ),
      ),
    );
  }
}

bool useIsFocused(FocusNode node) {
  final isFocused = useState(node.hasFocus);

  useEffect(
    () {
      void listener() {
        isFocused.value = node.hasFocus;
      }

      node.addListener(listener);
      return () => node.removeListener(listener);
    },
    [node],
  );

  return isFocused.value;
}
```

Whoa, that's a lot!
But that's all we need!
Don't worry, we'll go through it 
and explain what we just did!

### 4.1. `TodoItem` 

If we look at the `Todo` item,
we see that it *extends*
`HookConsumerWidget`.
To access the state within the 
providers we created beforehand,
we need our widgets to extend
`ConsumerWidget`.
The difference between
`ConsumerWidget` and `HookConsumerWidget`
is that the latter
just allows us to use hooks.
Hooks, as mentioned prior,
aren't `Riverpod`-related at all.
They just allow us to write code 
regarding the widget lifecycle and state.
This concept is borrowed from `React`
and you can learn more about them
here: https://docs-v2.riverpod.dev/docs/about_hooks.

As we stated, 
to access the provider value,
we extend with `ConsumerWidget`.
By extending with this,
the widget will have access
to a `ref` in the `build()`
function with wich we can
access the providers.
Hence why the
`final todo = ref.watch(_currentTodo);` 
line inside `TodoItem`.

The `_currentTodo` is a
small provider that refers
to the local state of the `TodoItem`.
We did this just for optimization purposes.
We could have a `StatefulWidget` in which 
we pass the `Todo` object 
when creating this `TodoItem` widget.

If you check the code,
the `TodoItem` will allow users to
edit the `Todo` item by tapping it.
When it taps/focusing,
the description becomes editable.

They can edit by changing
the text and then unfocusing 
(e.g. tapping away from the `TodoItem` widget).

```dart
onFocusChange: (focused) {
  if (focused) {
    textEditingController.text = todo.description;
  } else {
    // Commit changes only when the textfield is unfocused, for performance
    ref.read(todoListProvider.notifier).edit(id: todo.id, description: textEditingController.text);
  }
},
```

`ref.read(todoListProvider.notifier)`
returns the `TodoList` 
(remember that the `TodoList` 
`StateNotifier` object?)
in which we can call the `edit()` function
to edit the `todo` item.

The `TodoItem` also has a `Checkbox`,
that shows if the `todo` item is 
completed or not.

```dart
leading: Checkbox(
  value: todo.completed,
  onChanged: (value) => ref.read(todoListProvider.notifier).toggle(todo.id),
),
```

Similarly to before,
we call the `toggle()` function
inside the `TodoList` to
toggle the `todo` item between
"completed" or not.

And that's how we access
and effectively change the 
shared state we defined through
providers prior!
Heck yeah! 🎉

### 4.2. The `Menu`

Let's go over the menu.
The menu is located 
in the bottom of the screen.
It has three buttons, 
each one referring to the filter
we want to apply to the 
`TodoList`.
By default, the `All` is chosen, 
which shows the `TodoList` without filters.
But we can also show the `Active` todos
and `Completed` todos!

So, it makes sense to make use 
of the `todoListFilter` provider
we defined earlier,
which gives us information about the 
current filter we need to be displaying.
We access it by 
`final filter = ref.watch(todoListFilter);`

When a user wants to change filter,
we want to change `todoListFilter`.
For that, we simply change it like 
so:

```dart
onTap: (value) {
  if (value == 0) ref.read(todoListFilter.notifier).state = TodoListFilter.all;
  if (value == 1) ref.read(todoListFilter.notifier).state = TodoListFilter.active;
  if (value == 2) ref.read(todoListFilter.notifier).state = TodoListFilter.completed;
},
```

### 4.3. `Home`

Here's the last piece of the puzzle! 🧩
In the `Home` widget,
we are doing three things:
- creating a `todo` item.
- showing the number of `todo` items
left that aren't completed.
- displaying the filtered `todoList`.


Let's go over each of these.

#### 4.3.1. Creating a `todo` item

On top of the page,
you might notice there is 
`Textfield` with a placeholder
saying "What do we need to do?".
This is where the user creates 
a `todo` item.
Luckily, to create a `todo` item
is simple and it follows the same
pattern as editing 
and toggling a `todo` item.

```dart
TextField(
  key: addTodoKey,
  controller: newTodoController,
  decoration: const InputDecoration(
    labelText: 'What do we need to do?',
  ),
  onSubmitted: (value) {
    ref.read(todoListProvider.notifier).add(value);
    newTodoController.clear();
  },
)
```

By calling `ref.read(todoListProvider.notifier).add(value);`,
we take the `value` of the textfield
and create a new `todo` item
by using the `add()` function
of the `TodoList` class.
A [`Textfield`](https://api.flutter.dev/flutter/material/TextField-class.html)
necessitates a `controller`,
which is created using the
`useTextEditingController`.
A controller, 
as the name suggests,
manages the state of the `Textfield`.
In this case, we use it to 
clear the text after adding the `todo` item to the list.
This piece of information is outside of the scope
but it shows how easy it is to use hooks
and allows us to write less code
to achieve the same thing 😃.

#### 4.3.2. Displaying number of incomplete `todo` items

It is as easy as pie
to display the number of
incomplete `todo` items!
We just need to access
the `uncompletedTodosCount` provider
we defined earlier. 
It only holds an integer value,
so we can simply print it.

```dart
Text(
'${ref.watch(uncompletedTodosCount)} items left',
style: const TextStyle(fontSize: 20)
),
```

#### 4.3.3. Displaying the filtered `todoList`
The most important part
is showing the `todo` items, isn't it?
For that, 
we make use of the `filteredTodos`
provider we defined in the
`lib/provider.dart` file.
We just need to go over
the filtered list and 
show it to the user!
`filteredTodos` already knows
which items they need to show for us
because they change whenever 
`todoListFilter` changes 
(we explained this beforehand).
We access the `filteredTodos`
like so: 
`final todos = ref.watch(filteredTodos);`

Afterwards, in the `build()` function,
we go over the `todos` variable
and create `TodoItem` widgets like so.

```dart
for (var i = 0; i < todos.length; i++) ...[

  if (i > 0) const Divider(height: 0),
  ProviderScope(
      overrides: [
        _currentTodo.overrideWithValue(todos[i]),
      ],
      child: const TodoItem(),
  ),

]
```

Remember when we used the
`_currentTodo` provider in the `TodoItem`?
We are the using `ProviderScope`
function to **override** the value inside
the `TodoItem`. 
With this, the `TodoItem` now pertains
correctly to a given `todo` item and shows
the information correctly.

And that should be it!
You just *leveraged `Riverpod`* and 
created shared data that is
reusable across all the widgets
within the application!

But we don't stop here.
We want to persist these todo items
in an API and fetch accordingly.

Let's roll. 🏃

## 5. Embedding API
//TODO

