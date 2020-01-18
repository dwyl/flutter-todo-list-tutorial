<div align="center">

# Todo List Flutter Tutorial

This Tutorial will show you process of building of a todo-list with Flutter.

![Screen Shot 2020-01-15 at 11 04 33](https://user-images.githubusercontent.com/27420533/72429017-d8c29e80-3786-11ea-9682-303989093526.png)

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

## MOOR

Moor is an easy to use, reactive persistence library for Flutter apps. Define your database tables in pure Dart and enjoy a fluent query API, auto-updating streams and more!

## _How?_


 1-Create a new Flutter Project.

![image](https://user-images.githubusercontent.com/27420533/72510378-3f0bf780-3841-11ea-840d-6d56f8663357.png)


2-Delete all the "main.dart" comments that are generated after creating a new project.


### Design

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

8- Inside that "Row" you will have a children.Then it is necessary to add two "IconButton".


```ruby
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
            )
```
9- To add the Shape of the footer before Row, it is necessary to add the "shape" function and look for "CircularNotchedRectangle".


```ruby
 bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
```

This will be the final result of our bar.

![Screen Shot 2020-01-16 at 09 44 31](https://user-images.githubusercontent.com/27420533/72513312-dc1c5f80-3844-11ea-9766-b280988969c1.png)



10- To write the Application Name we go to the _MainContent class and inside the return Scaffold we add a SizedBox, a child and then we add a Text with what we want to write.

```ruby
 SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            "Todo List ",
```

11- Now we have to create the buttons one for the tasks and one for the events.
For that right after the Text we open another Row.<br />

Inside this Row we will have a child then we add a "MaterialButton" with a child who takes a Text with the text that appears on the button.



```ruby
return Row(                                               
  children: <Widget>[                                     
    Expanded(                                             
        child: CustomButton(                              
          onPressed: () {                                 
            _pageController.previousPage(                 
                duration: Duration(milliseconds: 500),    
                curve: Curves.bounceInOut);               
          },                                              
          buttonText: "Tasks",                            
                                         
```
This will be the final layout of the two buttons and our title. 


![Screen Shot 2020-01-16 at 11 45 50](https://user-images.githubusercontent.com/27420533/72522520-d24f2800-3855-11ea-830e-2155907ed51f.png)

12- To create the tasks we must use Radio Buttons that will be placed under the name of the application.<br />
It will take the function "radio_button_unchecked".<br />
Tasks can be added through "_taskUncomplete".

13- Create two new widgets one for tasks already done and one for tasks that have not yet been done.<br />

The two will take radio buttons and the one for the tasks already done takes checked radio buttons and the one for the tasks not yet done takes unchecked radio buttons.

![Screen Shot 2020-01-18 at 11 44 40](https://user-images.githubusercontent.com/27420533/72663220-fd698100-39e7-11ea-884a-fca5b13e78da.png)


![Screen Shot 2020-01-18 at 11 43 56](https://user-images.githubusercontent.com/27420533/72663223-0d816080-39e8-11ea-9c8f-9c1a4666c5d2.png)


## Task/Event Page

1- First hide the debug banner.


```ruby
child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',                           
                                         
```
2- Now we'll have to create another package that will contain the events and tasks page separately.

![Screen Shot 2020-01-18 at 10 49 58](https://user-images.githubusercontent.com/27420533/72662537-5d5c2980-39e0-11ea-84cd-1a54bdd15b53.png)

### How to Create/Add new Package inside src folder

1- Open Android Studio and Navigate to any view(Android or Project)<br />
2- In Android View you will have two folders: app and Gradle Scripts<br />
3- Open App folder then open Java folder. Right click on Java folder and select New > Package.<br />

![newpackage](https://user-images.githubusercontent.com/27420533/72662715-546c5780-39e2-11ea-8eff-6118fcd0c339.jpeg)


4- Choose directory destination which main\java and click OK.

![Screen Shot 2020-01-18 at 11 07 54](https://user-images.githubusercontent.com/27420533/72662780-2fc4af80-39e3-11ea-8ac0-043ca3e7be6b.png)


5- Give a name to new Package(For example: pages). Click Ok.

![Screen Shot 2020-01-18 at 11 13 59](https://user-images.githubusercontent.com/27420533/72662829-b5e0f600-39e3-11ea-9f27-95c2d9d4acfe.png)
 
3- After creating the new package. Right click on the package and Select New > Dart File.<br />
Name the New Dart File > task_page.dart.<br />

4- Create another one called event_page.dart.<br />

5- Inside the taks_page.dart create a new StatefulWidget, and import your material.dart.<br />

![Screen Shot 2020-01-18 at 11 32 31](https://user-images.githubusercontent.com/27420533/72663097-589a7400-39e6-11ea-84bf-b6c4711ec0b3.png)

![Screen Shot 2020-01-18 at 11 32 14](https://user-images.githubusercontent.com/27420533/72663101-66e89000-39e6-11ea-9f3c-57e2d7444c92.png)

6- Move all the related task code to task widget.

7- Display task widgets in main content.

![Screen Shot 2020-01-18 at 12 29 01](https://user-images.githubusercontent.com/27420533/72663781-2d1b8780-39ee-11ea-9869-89f31c47eee7.png)


8- Don't Forget to initiate itemCount in ListView.


![Screen Shot 2020-01-18 at 12 32 09](https://user-images.githubusercontent.com/27420533/72663829-b59a2800-39ee-11ea-8b3d-96458d521060.png)


### Event Page

1- Create the StatefulWidget in the event_page.dart and import the material.dart package.

2- Now in the _EventPageState change the return Column to return Listview.builder.

```ruby
class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    double iconSize = 20;

    return ListView.builder(
      itemCount: _eventList.length,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24),
                              
                                         
```
3- We have icon, time and description,so we wrap all to Row.



```ruby

     child: Row(
            children: <Widget>[
              _lineStyle(context, iconSize, index, _eventList.length,
                  _eventList[index].isFinish),
              _displayTime(_eventList[index].time),
              _displayContent(_eventList[index]) 
     
                                         
```

4- For description we wrap in Column because it have 2 lines.


![Screen Shot 2020-01-18 at 13 14 34](https://user-images.githubusercontent.com/27420533/72664334-871f4b80-39f4-11ea-955e-c2ebe1efbc97.png)

5- Now it's time to draw the line.


```ruby
Widget _lineStyle(BuildContext context, double iconSize, int index,
      int listLength, bool isFinish) {
    return Container(
        decoration: CustomIconDecoration(
            iconSize: iconSize,
            lineWidth: 1,
            firstData: index == 0 ?? true,
            lastData: index == listLength - 1 ?? true),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 3),
                    color: Color(0x20000000),
                    blurRadius: 5)
              ]),
              
 ``` 
 6- Define the position for Draw Line.
 
 
```ruby 
   void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final leftOffset = Offset((iconSize / 2) + 24, offset.dy);
    final double iconSpace = iconSize / 1.5;

    final Offset top = configuration.size.topLeft(Offset(leftOffset.dx, 0.0));
    final Offset centerTop = configuration.size
        .centerLeft(Offset(leftOffset.dx, leftOffset.dy - iconSpace));

    final Offset centerBottom = configuration.size
        .centerLeft(Offset(leftOffset.dx, leftOffset.dy + iconSpace));
    final Offset end =
    configuration.size.bottomLeft(Offset(leftOffset.dx, leftOffset.dy * 2));

    if (!firstData) canvas.drawLine(top, centerTop, paintLine);
    if (!lastData) canvas.drawLine(centerBottom, end, paintLine);
  }
}
              
 ``` 
 
7- Define value for Icon Size, and assign value for firstData and LastData.


```ruby 
return Container(
        decoration: CustomIconDecoration(
            iconSize: iconSize,
            lineWidth: 1,
            firstData: index == 0 ?? true,
            lastData: index == listLength - 1 ?? true),
              
 ``` 
8- Create the Object for Event.

```ruby 
class Event {
  final String time;
  final String task;
  final String desc;
  final bool isFinish;

  const Event(this.time, this.task, this.desc, this.isFinish);
}

final List<Event> _eventList = [
  new Event("08:00", "Have coffe with Sam", "Personal", true),
  new Event("10:00", "Meet with sales", "Work", true),
  new Event("12:00", "Call Tom about appointment", "Work", false),
  new Event("14:00", "Fix onboarding experience", "Work", false),
  new Event("16:00", "Edit API documentation", "Personal", false),
  new Event("18:00", "Setup user focus group", "Personal", false),
];

              
 ``` 
 
## Insert Page

1- Create a new Dart file called "add_task_page.dart",import your material.dart and create a new StatefulWidget.<br />
After that change the Return Container to Return Text and add the Text "Add New Task".<br />

```ruby
  mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text(
                "Add new task",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )),
 
              
 ```      
     
2- Create a CustomTextField that contais a labelText with the Text "Enter task Name".     
     
```ruby
     CustomTextField(
              labelText: 'Enter task name', controller: _textTaskControler),
          SizedBox(height: 12),
              
 ```   
 
 3- Create a new Package Called Widgets , inside this package is where all the elements of interaction that we will use in our application will be.
 
 
 ![Screen Shot 2020-01-18 at 21 58 08](https://user-images.githubusercontent.com/27420533/72671141-be661a80-3a3d-11ea-849d-93fb89063ed8.png)
 
 
 4- Create a Dart file called Custom_button.dart, inside that button add the StatelessWidget and import the material.dart.<br />
 Create the CustomButton Object.<br />
      
```ruby
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color color;
  final Color textColor;
  final Color borderColor;

              
 ```  
 
 
 
 
 
 
 
