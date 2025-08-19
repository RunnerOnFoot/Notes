// Import necessary packages and data models.
import 'package:flutter/material.dart';
import '../data/task_type.dart';

// A stateless widget that displays a single task type item in a list.
class TaskTypeItemList extends StatelessWidget {
  TaskTypeItemList({
    super.key,
    required this.taskType,
    required this.index,
    required this.selectdItemList,
  });

  // The index of this item in the list.
  final int index;
  // The index of the currently selected item in the list.
  final int selectdItemList;
  // The TaskType data for this item.
  final TaskType taskType;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Decorate the container to show selection state.
      decoration: BoxDecoration(
        // Change color based on whether the item is selected.
        color: index == selectdItemList ? const Color(0xff18daa3) : Colors.grey,
        border: Border.all(
          // Show a border if the item is selected.
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Display the image for the task type.
          Image.asset(taskType.image),
          const SizedBox(height: 8),
          // Display the title of the task type.
          Text(
            taskType.title,
            style: TextStyle(
              // Change text color based on selection.
              color: index == selectdItemList ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
