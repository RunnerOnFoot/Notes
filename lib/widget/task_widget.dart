// Import necessary packages and screens.
import 'package:flutter/material.dart';
import 'package:notes/data/task.dart';
import '../screens/edit_task.dart';

// A stateful widget that displays a single task.
class TaskWidget extends StatefulWidget {
  TaskWidget({super.key, required this.task});

  // The task data to be displayed.
  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  // A boolean to track the checked state of the task.
  bool isBoxChecked = false;

  @override
  void initState() {
    super.initState();
    // Initialize the checked state from the task data.
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return _getTaskItem();
  }

  // Builds the main container for the task item.
  Widget _getTaskItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _getMainContent(),
        ),
      ),
    );
  }

  // Builds the main content of the task item.
  Widget _getMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // Row for the checkbox and task title.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Checkbox to mark the task as done.
                  Transform.scale(
                    scale: 1.4,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      activeColor: const Color(0xff18daa3),
                      value: isBoxChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isBoxChecked = value!;
                          widget.task.isDone = isBoxChecked;
                          widget.task.save(); // Save the updated task status.
                        });
                      },
                    ),
                  ),
                  // Display the task title.
                  Text(widget.task.title.isEmpty
                      ? 'بدون عنوان'
                      : widget.task.title),
                ],
              ),
              // Display the task subtitle.
              Text(
                widget.task.subTitle.isEmpty
                    ? 'بدون توضیحات'
                    : widget.task.subTitle,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              // Row for the time and edit badges.
              _getTimeAndEditBadges(),
            ],
          ),
        ),
        const SizedBox(width: 20),
        // Display the image for the task type.
        Image.asset(widget.task.taskType.image),
      ],
    );
  }

  // Builds the time and edit badges.
  Widget _getTimeAndEditBadges() {
    return Row(
      children: <Widget>[
        // Time badge.
        Container(
          width: 86,
          height: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: const Color(0xff18daa3),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Display the task time.
                widget.task.time != null
                    ? Text(
                        '${widget.task.time!.hour}:${widget.task.time!.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Text(
                        '00:00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                const SizedBox(width: 8),
                Image.asset('assets/images/icon_time.png'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        // Edit button.
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => EditTask(
                  task: widget.task,
                ),
              ),
            );
          },
          child: Container(
            width: 87,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: const Color(0xffe2f6f1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'ویرایش',
                    style: TextStyle(
                      color: Color(0xff18daa3),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Image.asset('assets/images/icon_edit.png'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
