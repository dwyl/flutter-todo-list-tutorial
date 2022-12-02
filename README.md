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


