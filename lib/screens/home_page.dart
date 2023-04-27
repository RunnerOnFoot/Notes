import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:notes/widget/task_widget.dart';

import '../data/task.dart';
import 'add_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isChecked = false;

  var taskbox = Hive.box<Task>('taskBox');

  bool isFabVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe5e5e5),
      body: Center(
        child: ValueListenableBuilder(
            valueListenable: taskbox.listenable(),
            builder: (BuildContext context, Object value, Widget? child) {
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
                child: ListView.builder(
                  itemCount: taskbox.values.length,
                  itemBuilder: (BuildContext context, int index) {
                    Task task = taskbox.values.toList()[index];

                    return _getListItem(task);
                  },
                ),
              );
            }),
      ),
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

  Widget _getListItem(Task task) {
    return Dismissible(
      onDismissed: (DismissDirection direction) {
        task.delete();
      },
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
                      Navigator.of(context).pop(false);
                    },
                    child: const Text(
                      'خیر',
                      style: TextStyle(color: Color(0xff18daa3)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
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
      key: UniqueKey(),
      child: TaskWidget(
        task: task,
      ),
    );
  }
}
