// Import necessary packages for UI, database, and widgets.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/data/task.dart';
import 'package:notes/screens/add_task.dart';
import 'package:notes/widget/task_widget.dart';

// The main screen of the application, displaying a list of tasks.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // The Hive box for storing tasks.
  final taskbox = Hive.box<Task>('taskBox');
  // A boolean to control the visibility of the FloatingActionButton.
  bool isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe5e5e5),
      body: Center(
        // ValueListenableBuilder listens to the task box and rebuilds the UI when data changes.
        child: ValueListenableBuilder(
          valueListenable: taskbox.listenable(),
          builder: (BuildContext context, Object value, Widget? child) {
            // NotificationListener detects scroll events to show/hide the FAB.
            return NotificationListener<UserScrollNotification>(
              onNotification: (UserScrollNotification notification) {
                setState(() {
                  if (notification.direction == ScrollDirection.forward) {
                    isFabVisible = true;
                  }
                  if (notification.direction == ScrollDirection.reverse) {
                    isFabVisible = false;
                  }
                });
                return true;
              },
              // ListView.builder efficiently builds the list of tasks.
              child: ListView.builder(
                itemCount: taskbox.values.length,
                itemBuilder: (BuildContext context, int index) {
                  Task task = taskbox.values.toList()[index];
                  return _getListItem(task);
                },
              ),
            );
          },
        ),
      ),
      // FloatingActionButton for adding new tasks.
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          backgroundColor: const Color(0xff18daa3),
          child: Image.asset('assets/images/icon_add.png'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const AddTask(),
              ),
            );
          },
        ),
      ),
    );
  }

  // Returns a Dismissible widget for a task item, allowing swipe-to-delete.
  Widget _getListItem(Task task) {
    return Dismissible(
      // Called when the item is dismissed.
      onDismissed: (DismissDirection direction) {
        task.delete();
      },
      // Asks for confirmation before dismissing.
      confirmDismiss: (DismissDirection direction) {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                backgroundColor: Colors.white,
                title: const Text('پاک کردن'),
                content: const Text('این آیتم پاک شود ؟'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false); // Don't dismiss.
                    },
                    child: const Text(
                      'خیر',
                      style: TextStyle(color: Color(0xff18daa3)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true); // Dismiss.
                    },
                    child: const Text(
                      'بله',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      key: UniqueKey(), // A unique key for each Dismissible item.
      child: TaskWidget(
        task: task,
      ),
    );
  }
}
