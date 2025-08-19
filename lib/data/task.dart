// Import necessary packages.
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/data/task_type.dart';

// This line indicates that 'task.g.dart' is a generated file that is part of this library.
part 'task.g.dart';

// Annotate the class with @HiveType to generate a TypeAdapter. 'typeId' must be unique.
@HiveType(typeId: 3)
// The Task class extends HiveObject to be storable in a Hive box.
class Task extends HiveObject {
  // Constructor for the Task class.
  Task({
    required this.title,
    required this.subTitle,
    this.isDone = false,
    required this.time,
    required this.taskType,
  });

  // Annotate each field with @HiveField and a unique index.
  @HiveField(0)
  String title; // The title of the task.

  @HiveField(1)
  String subTitle; // The subtitle or description of the task.

  @HiveField(2)
  bool isDone; // A flag to indicate if the task is completed.

  @HiveField(3)
  DateTime? time; // The date and time for the task. It can be null.

  @HiveField(4)
  TaskType taskType; // The type of the task, which is a custom object.
}
