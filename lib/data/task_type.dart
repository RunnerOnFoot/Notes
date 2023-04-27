import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/data/type_enum.dart';

part 'task_type.g.dart';

@HiveType(typeId: 4)
class TaskType {
  TaskType({
    required this.image,
    required this.title,
    required this.enumType,
  });

  @HiveField(0)
  String image;

  @HiveField(1)
  String title;

  @HiveField(2)
  TaskTypeEnum enumType;
}
