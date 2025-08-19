// Import data models used in this utility file.
import 'package:notes/data/task_type.dart';
import 'package:notes/data/type_enum.dart';

// This function returns a list of predefined TaskType objects.
List<TaskType> getTaskTypeList() {
  // Create a list to hold the task types.
  List<TaskType> list = <TaskType>[
    // Each TaskType object represents a category of task.
    TaskType(
      image: 'assets/images/meditate.png',
      title: 'تمرکز', // "Focus" in Persian
      enumType: TaskTypeEnum.foucs,
    ),
    TaskType(
      image: 'assets/images/social_frends.png',
      title: 'میتینگ', // "Meeting" in Persian
      enumType: TaskTypeEnum.date,
    ),
    TaskType(
      image: 'assets/images/hard_working.png',
      title: 'کار زیاد', // "Hard work" in Persian
      enumType: TaskTypeEnum.working,
    ),
    TaskType(
      image: 'assets/images/banking.png',
      title: 'کار اداری', // "Official work" in Persian
      enumType: TaskTypeEnum.official,
    ),
    TaskType(
      image: 'assets/images/workout.png',
      title: 'ورزش', // "Exercise" in Persian
      enumType: TaskTypeEnum.gym,
    ),
    TaskType(
      image: 'assets/images/work_meeting.png',
      title: 'میتینگ کاری', // "Work meeting" in Persian
      enumType: TaskTypeEnum.businessDate,
    ),
  ];

  // Return the list of task types.
  return list;
}
