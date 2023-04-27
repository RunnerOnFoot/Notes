import 'package:flutter/material.dart';

import '../data/task_type.dart';

class TaskTypeItemList extends StatelessWidget {
  TaskTypeItemList({
    super.key,
    required this.taskType,
    required this.index,
    required this.selectdItemList,
  });

  int index;
  int selectdItemList;

  TaskType taskType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: index == selectdItemList ? const Color(0xff18daa3) : Colors.grey,
        border: Border.all(
          color: index == selectdItemList
              ? const Color(0xff18daa3)
              : Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(8),
      width: 140,
      child: Column(
        children: <Widget>[
          Image.asset(taskType.image),
          Text(
            taskType.title,
            style: TextStyle(
              color: index == selectdItemList ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
