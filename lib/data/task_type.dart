// Import necessary packages.
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/data/type_enum.dart';

// This line indicates that 'task_type.g.dart' is a generated file that is part of this library.
part 'task_type.g.dart';

// Annotate the class with @HiveType to generate a TypeAdapter. 'typeId' must be unique.
@HiveType(typeId: 4)
// The TaskType class defines the structure for a type of task.
class TaskType {
  // Constructor for the TaskType class.
  TaskType({
    required this.image,
    required this.title,
    required this.enumType,
  });

  // Annotate each field with @HiveField and a unique index.
  @HiveField(0)
  String image; // The path to the image asset for this task type.

  @HiveField(1)
  String title; // The title of the task type.

  @HiveField(2)
  TaskTypeEnum enumType; // The enum value associated with this task type.
}
