import 'package:hive_flutter/hive_flutter.dart';

part 'type_enum.g.dart';

@HiveType(typeId: 5)
enum TaskTypeEnum {
  @HiveField(0)
  working,

  @HiveField(1)
  date,

  @HiveField(2)
  foucs,

  @HiveField(3)
  official,

  @HiveField(4)
  gym,

  @HiveField(5)
  businessDate,
}
