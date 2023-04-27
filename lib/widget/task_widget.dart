import 'package:flutter/material.dart';

import '../data/task.dart';
import '../screens/edit_task.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({super.key, required this.task});

  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;

  @override
  void initState() {
    isBoxChecked = widget.task.isDone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getTaskItem();
  }

  Widget _getTaskItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Container(
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _getMainContent(),
        ),
      ),
    );
  }

  Widget _getMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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

                          widget.task.save();
                        });
                      },
                    ),
                  ),
                  Text(widget.task.title.isEmpty
                      ? 'بدون عنوان'
                      : widget.task.title),
                ],
              ),
              Text(
                widget.task.subTitle.isEmpty
                    ? 'بدون توضیحات'
                    : widget.task.subTitle,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              _getTimeAndEditBadgs(),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Image.asset(widget.task.taskType.image),
      ],
    );
  }

  Widget _getTimeAndEditBadgs() {
    return Row(
      children: <Widget>[
        Container(
          width: 85,
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
                widget.task.time != null
                    ? Text(
                        '${widget.task.time!.hour}:${widget.task.time!.minute}',
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
            width: 85,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: const Color(0xffe2f6f1),
            ),
            child: Row(
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
      ],
    );
  }
}
