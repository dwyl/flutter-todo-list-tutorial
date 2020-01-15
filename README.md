<div align="center">

# Todo List Flutter Tutorial

This Tutorial will show you process of building of a todo-list with Flutter.

</div>

## Why?

This application aims to test knowledge acquired with Flutter through an example of an application that can be used in real life (day-to-day).

Apps developed using Flutter are faster compared to other multi-platform frameworks. <br />
Because they have their own widgets, applications in Flutter have a lightweight interface that allows a great user experience.<br />

Unlike its main competitor (React Native), Flutter has a very simple and practical installation and configuration setup, even on 
Linux.<br />
With few commands (Flutter doctor, for example), you can check for problems and how to fix them. Some IDEs, like Intellij IDEA, Android Studio and VS Code, have integration with Dart/Flutter through plugins, making the experience more advantageous to the developer.

## What?

Let's create a fully functional Todo List through Flutter.<br />
During this tutorial we will achieve:

+ [x] Create the design for a day-to-day Application
+ [x] Create another folder and pages within the project
+ [x] How to show the various pages (Events/Tasks)
+ [x] Creating an Insert Page
+ [x] Working with page transitions
+ [x] How to work with the Flutter MOOR database in order to save all events and tasks already performed

### Todo List?

At their most basic, to-dos contain all of the tasks that you need to complete on a given day.<br /> It’s a great device for managing time that enables you to lay out everything that you need to accomplish and plan and prioritize your day from there.<br /> You can also make to-dos for major tasks like a work assignment or an overall goal. 


### Why learn to use them?

The main purpose of a to-do is to help organize tasks, so learning to effectively use them will benefit you by improving your time management abilities and decreasing your stress levels.<br />
A to-do allows you to better manage your time by allowing you to lay out what you need to accomplish and then coordinate your time from there. When you first compose it, you’ll note the most important tasks and make time for them.

## Who?

This tutorial is for all people looking to develop their skills with Flutter while building a day-to-day application.<br />
For all people looking to improve the organization of time.

### Prerequisites to this Tutorial

Everyone looking to learn more about Flutter should be able to perform this application without problems.<br />
If you get stuck in one step the best thing to do is to open an issue because besides us being able to answer quickly , other people who have the same doubt can be helped.<br />
If you need to open an issue here is the link to open that issue: https://github.com/dwyl/flutter-todo-list-tutorial/issues

## _How?_

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
6-Inside the body add a Column to store the day of the week.

```ruby
 child: Text(
            "Monday",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),

```
7- Create a "CustomButton" to get the tasks and another one for the events.

```ruby
child: CustomButton(
              onPressed: () {
                _pageController.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.bounceInOut);
              },
              buttonText: "Tasks",
              color:
              currentPage < 0.5 ? Theme.of(context).accentColor : Colors.white,
              textColor:
              currentPage < 0.5 ? Colors.white : Theme.of(context).accentColor,
              borderColor: currentPage < 0.5
                  ? Colors.transparent
                  : Theme.of(context).accentColor,
            )),

```
